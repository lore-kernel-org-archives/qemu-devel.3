Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E6BCEDD9C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXJ7-0001N4-1Q; Wed, 09 Oct 2024 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syXJ5-0001Mo-PP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 10:04:51 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syXJ2-00071s-TW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 10:04:51 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-50a5a72b935so1843354e0c.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728482688; x=1729087488;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PTsp4AY2TFBV8FVa5M4I58DD5eBCOHu1R0FoC83Kkik=;
 b=qzUNTePJrbpLzHwLBR8LbxEI0pS0bgSda4AhkwIhz4CmKxwk2OLIDCLoKzhU8Z2gFB
 6n8+0knDNymr8OJtuQZ9wQV85rX6f7xDNMp4WsTcy5cci5zvUJaTF1kScuzTn3lnvFrD
 UanJDS4ESu7YXBeesiBPDvEEZsqBzcBf4Ya89ZKoTFy7bjWxSdVSwq8WxSKdmxnaSZ7f
 860QiNPQJNljO1AX61zJddxH2+mW4j0yLx+NsnYpDAh97fmhwD+y/J5avf1txfwhW4oQ
 8eQpc7zbk0Y5VezGTMhZpKrGzwxuCCrhnUmrh0vrvXC+3bHZrXi5BATW9RuYwtbRxAcS
 3mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482688; x=1729087488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PTsp4AY2TFBV8FVa5M4I58DD5eBCOHu1R0FoC83Kkik=;
 b=NPYJ/x8UXnGeITWacmt+jY0OmdVR82W+L46tkNHsWSgO++9hDmcfqQwrK37y/ufHqM
 Pa24SLtNzhYIBcjsuEwEqMhVyJv0XWT8LqJeySg228lITXNrIk6iHfAt4Po4ELg+7lVB
 v8G8i8sh0vKZFv7vceufuW/EKyEkkAzt+NHe5Gikjv5j1c0pj4B9GCreZGIYB9i0MtM5
 83BjW7jyk3xnyGv3I/tx/i3yDQ7Z3ZvMKy/2IN2reTFLb9WNSxIv3vBDajH0NZCKc9ly
 n+fQ40OYWs73MDP8Et75QQu0P4tXUGy00psaVk5BvJ6fiXyhYG5PLksIOo6bC+AtyNY7
 lnkw==
X-Gm-Message-State: AOJu0YxTnywewJiSpWs2rKS1c0drtrUyAAJ72DR3uTV4+uOdY3ca8u2P
 TaBV2QNgKafvKLJvgDjDcQwfj1mMgQhNFVeB0wQqOrP8kiDksOLRhdXhL9zSupDc12WUfbjwj7F
 zk8U6ML/EH0Bcs2oUYP9N9I8BlDf9os0vdvDM
X-Google-Smtp-Source: AGHT+IFJFf1AjfYGJq4t4EU9oiyOLds90e+nHNoDMC0gs7NlK2xOqy3bhXbJzabKdD+oglq6PrJ9+kHLtPaT3czEpSw=
X-Received: by 2002:a05:6122:21a4:b0:50a:ba7b:5a23 with SMTP id
 71dfb90a1353d-50cf09b8658mr1469509e0c.6.1728482687674; Wed, 09 Oct 2024
 07:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-5-phil@philjordan.eu>
 <ab82d2b3-4b06-4f9e-b58a-ea9a5d6c5000@daynix.com>
In-Reply-To: <ab82d2b3-4b06-4f9e-b58a-ea9a5d6c5000@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 16:04:36 +0200
Message-ID: <CAAibmn3JxwY4ZF0nNxZpR5ULwCaVhD0X-VU8h_gDu7Kgr_UpHw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] hw/display/apple-gfx: Adds configurable mode list
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009983f206240bbcdb"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000009983f206240bbcdb
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 06:17, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> > This change adds a property 'display_modes' on the graphics device
> > which permits specifying a list of display modes. (screen resolution
> > and refresh rate)
> >
> > PCI variant of apple-gfx only for the moment.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   hw/display/apple-gfx-pci.m |  43 ++++++++++-
> >   hw/display/apple-gfx.h     |  17 ++++-
> >   hw/display/apple-gfx.m     | 151 ++++++++++++++++++++++++++++++++++---
> >   3 files changed, 198 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> > index 9370258ee46..ea86a1f4a21 100644
> > --- a/hw/display/apple-gfx-pci.m
> > +++ b/hw/display/apple-gfx-pci.m
> > @@ -16,6 +16,7 @@
> >   #include "apple-gfx.h"
> >   #include "hw/pci/pci_device.h"
> >   #include "hw/pci/msi.h"
> > +#include "hw/qdev-properties.h"
> >   #include "qapi/error.h"
> >   #include "trace.h"
> >   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > @@ -101,6 +102,46 @@ static void apple_gfx_pci_reset(Object *obj,
> ResetType type)
> >       [s->common.pgdev reset];
> >   }
> >
> > +static void apple_gfx_pci_get_display_modes(Object *obj, Visitor *v,
> > +                                            const char *name, void
> *opaque,
> > +                                            Error **errp)
> > +{
> > +    Property *prop = opaque;
> > +    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj,
> prop);
> > +
> > +    apple_gfx_get_display_modes(mode_list, v, name, errp);
> > +}
> > +
> > +static void apple_gfx_pci_set_display_modes(Object *obj, Visitor *v,
> > +                                            const char *name, void
> *opaque,
> > +                                            Error **errp)
> > +{
> > +    Property *prop = opaque;
> > +    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj,
> prop);
> > +
> > +    apple_gfx_set_display_modes(mode_list, v, name, errp);
> > +}
> > +
> > +const PropertyInfo apple_gfx_pci_prop_display_modes = {
> > +    .name  = "display_modes",
> > +    .description =
> > +        "Colon-separated list of display modes; "
> > +        "<width>x<height>@<refresh-rate>; the first mode is considered "
> > +        "'native'. Example: 3840x2160@60:2560x1440@60:1920x1080@60",
>
> Please use DEFINE_PROP_ARRAY() instead of inventing your own way to
> define an array.
>

Looks like the ability to specify array properties on the Qemu command line
has recently been added. I'm pretty sure I still need the custom set/get
implementations for each array element (display mode) though.


> > +    .get   = apple_gfx_pci_get_display_modes,
> > +    .set   = apple_gfx_pci_set_display_modes,
> > +};
> > +
> > +#define DEFINE_PROP_DISPLAY_MODES(_name, _state, _field) \
> > +    DEFINE_PROP(_name, _state, _field,
> apple_gfx_pci_prop_display_modes, \
> > +                AppleGFXDisplayModeList)
> > +
> > +static Property apple_gfx_pci_properties[] = {
> > +    DEFINE_PROP_DISPLAY_MODES("display-modes", AppleGFXPCIState,
> > +                              common.display_modes),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> >   static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> > @@ -118,7 +159,7 @@ static void apple_gfx_pci_class_init(ObjectClass
> *klass, void *data)
> >       pci->class_id = PCI_CLASS_DISPLAY_OTHER;
> >       pci->realize = apple_gfx_pci_realize;
> >
> > -    // TODO: Property for setting mode list
> > +    device_class_set_props(dc, apple_gfx_pci_properties);
> >   }
> >
> >   static TypeInfo apple_gfx_pci_types[] = {
> > diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> > index 995ecf7f4a7..baad4a98652 100644
> > --- a/hw/display/apple-gfx.h
> > +++ b/hw/display/apple-gfx.h
> > @@ -5,14 +5,28 @@
> >   #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> >
> >   #include "qemu/typedefs.h"
> > +#include "qemu/osdep.h"
> >
> >   typedef struct AppleGFXState AppleGFXState;
> >
> > +typedef struct AppleGFXDisplayMode {
> > +    uint16_t width_px;
> > +    uint16_t height_px;
> > +    uint16_t refresh_rate_hz;
> > +} AppleGFXDisplayMode;
> > +
> > +typedef struct AppleGFXDisplayModeList {
> > +    GArray *modes;
> > +} AppleGFXDisplayModeList;
> > +
> >   void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name);
> > +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list,
> Visitor *v,
> > +                                 const char *name, Error **errp);
> > +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list,
> Visitor *v,
> > +                                 const char *name, Error **errp);
> >
> >   #ifdef __OBJC__
> >
> > -#include "qemu/osdep.h"
> >   #include "exec/memory.h"
> >   #include "ui/surface.h"
> >   #include <dispatch/dispatch.h>
> > @@ -38,6 +52,7 @@ struct AppleGFXState {
> >       bool new_frame;
> >       bool cursor_show;
> >       QEMUCursor *cursor;
> > +    AppleGFXDisplayModeList display_modes;
> >
> >       dispatch_queue_t render_queue;
> >       /* The following fields should only be accessed from render_queue:
> */
> > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > index 6ef1048d93d..358192db6a0 100644
> > --- a/hw/display/apple-gfx.m
> > +++ b/hw/display/apple-gfx.m
> > @@ -16,6 +16,9 @@
> >   #include "trace.h"
> >   #include "qemu-main.h"
> >   #include "qemu/main-loop.h"
> > +#include "qemu/cutils.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi/error.h"
> >   #include "ui/console.h"
> >   #include "monitor/monitor.h"
> >   #include "qapi/error.h"
> > @@ -23,9 +26,10 @@
> >   #include <mach/mach_vm.h>
> >   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >
> > -static const PGDisplayCoord_t apple_gfx_modes[] = {
> > -    { .x = 1440, .y = 1080 },
> > -    { .x = 1280, .y = 1024 },
> > +static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
> > +    { 1920, 1080, 60 },
> > +    { 1440, 1080, 60 },
> > +    { 1280, 1024, 60 },
> >   };
> >
> >   typedef struct PGTask_s { // Name matches forward declaration in PG
> header
> > @@ -264,7 +268,6 @@ static void set_mode(AppleGFXState *s, uint32_t
> width, uint32_t height)
> >   static void create_fb(AppleGFXState *s)
> >   {
> >       s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> > -    set_mode(s, 1440, 1080);
> >
> >       s->cursor_show = true;
> >   }
> > @@ -466,20 +469,24 @@ static void
> apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >       return disp_desc;
> >   }
> >
> > -static NSArray<PGDisplayMode*>*
> apple_gfx_prepare_display_mode_array(void)
> > +static NSArray<PGDisplayMode*>* apple_gfx_create_display_mode_array(
> > +    const AppleGFXDisplayMode display_modes[], int display_mode_count)
> >   {
> > -    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> > +    PGDisplayMode **modes = alloca(sizeof(modes[0]) *
> display_mode_count);
> >       NSArray<PGDisplayMode*>* mode_array = nil;
> >       int i;
> >
> > -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +    for (i = 0; i < display_mode_count; i++) {
> > +        const AppleGFXDisplayMode *mode = &display_modes[i];
> > +        PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px
> };
> >           modes[i] =
> > -            [[PGDisplayMode alloc]
> initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> > +            [[PGDisplayMode alloc] initWithSizeInPixels:mode_size
> > +
> refreshRateInHz:mode->refresh_rate_hz];
> >       }
> >
> > -    mode_array = [NSArray arrayWithObjects:modes
> count:ARRAY_SIZE(apple_gfx_modes)];
> > +    mode_array = [NSArray arrayWithObjects:modes
> count:display_mode_count];
> >
> > -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +    for (i = 0; i < display_mode_count; i++) {
> >           [modes[i] release];
> >           modes[i] = nil;
> >       }
> > @@ -516,6 +523,8 @@ static void
> apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >   void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor
> *desc)
> >   {
> >       PGDisplayDescriptor *disp_desc = nil;
> > +    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
> > +    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
> >
> >       QTAILQ_INIT(&s->tasks);
> >       s->render_queue = dispatch_queue_create("apple-gfx.render",
> > @@ -533,7 +542,127 @@ void apple_gfx_common_realize(AppleGFXState *s,
> PGDeviceDescriptor *desc)
> >       s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
> >                                                 port:0 serialNum:1234];
> >       [disp_desc release];
> > -    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> > +
> > +    if (s->display_modes.modes != NULL && s->display_modes.modes->len >
> 0) {
> > +        display_modes =
> > +            &g_array_index(s->display_modes.modes, AppleGFXDisplayMode,
> 0);
> > +        num_display_modes = s->display_modes.modes->len;
> > +    }
> > +    s->pgdisp.modeList =
> > +        apple_gfx_create_display_mode_array(display_modes,
> num_display_modes);
> >
> >       create_fb(s);
> >   }
> > +
> > +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list,
> Visitor *v,
> > +                                 const char *name, Error **errp)
> > +{
> > +    GArray *modes = mode_list->modes;
> > +    /* 3 uint16s (max 5 digits) and 3 separator characters per mode +
> nul. */
> > +    size_t buffer_size = (5 + 1) * 3 * modes->len + 1;
> > +
> > +    char *buffer = alloca(buffer_size);
> > +    char *pos = buffer;
> > +
> > +    unsigned used = 0;
> > +    buffer[0] = '\0';
> > +    for (guint i = 0; i < modes->len; ++i)
> > +    {
> > +        AppleGFXDisplayMode *mode =
> > +            &g_array_index(modes, AppleGFXDisplayMode, i);
> > +        int rc = snprintf(pos, buffer_size - used,
> > +                          "%s%"PRIu16"x%"PRIu16"@%"PRIu16,
> > +                          i > 0 ? ":" : "",
> > +                          mode->width_px, mode->height_px,
> > +                          mode->refresh_rate_hz);
> > +        used += rc;
> > +        pos += rc;
> > +        assert(used < buffer_size);
> > +    }
> > +
> > +    pos = buffer;
> > +    visit_type_str(v, name, &pos, errp);
> > +}
> > +
> > +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list,
> Visitor *v,
> > +                                 const char *name, Error **errp)
> > +{
> > +    Error *local_err = NULL;
> > +    const char *endptr;
> > +    char *str;
> > +    int ret;
> > +    unsigned int val;
> > +    uint32_t num_modes;
> > +    GArray *modes;
> > +    uint32_t mode_idx;
> > +
> > +    visit_type_str(v, name, &str, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    // Count colons to estimate modes. No leading/trailing colons so
> start at 1.
> > +    num_modes = 1;
> > +    for (size_t i = 0; str[i] != '\0'; ++i)
> > +    {
> > +        if (str[i] == ':') {
> > +            ++num_modes;
> > +        }
> > +    }
> > +
> > +    modes = g_array_sized_new(false, true, sizeof(AppleGFXDisplayMode),
> num_modes);
> > +
> > +    endptr = str;
> > +    for (mode_idx = 0; mode_idx < num_modes; ++mode_idx)
> > +    {
> > +        AppleGFXDisplayMode mode = {};
> > +        if (mode_idx > 0)
> > +        {
> > +            if (*endptr != ':') {
> > +                goto separator_error;
> > +            }
> > +            ++endptr;
> > +        }
> > +
> > +        ret = qemu_strtoui(endptr, &endptr, 10, &val);
> > +        if (ret || val > UINT16_MAX || val == 0) {
> > +            error_setg(errp, "width of '%s' must be a decimal integer
> number "
> > +                       "of pixels in the range 1..65535", name);
> > +            goto out;
> > +        }
> > +        mode.width_px = val;
> > +        if (*endptr != 'x') {
> > +            goto separator_error;
> > +        }
> > +
> > +        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
> > +        if (ret || val > UINT16_MAX || val == 0) {
> > +            error_setg(errp, "height of '%s' must be a decimal integer
> number "
> > +                       "of pixels in the range 1..65535", name);
> > +            goto out;
> > +        }
> > +        mode.height_px = val;
> > +        if (*endptr != '@') {
> > +            goto separator_error;
> > +        }
> > +
> > +        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
> > +        if (ret) {
> > +            error_setg(errp, "refresh rate of '%s'"
> > +                       " must be a non-negative decimal integer
> (Hertz)", name);
> > +        }
> > +        mode.refresh_rate_hz = val;
> > +        g_array_append_val(modes, mode);
> > +    }
> > +
> > +    mode_list->modes = modes;
> > +    goto out;
> > +
> > +separator_error:
> > +    error_setg(errp, "Each display mode takes the format "
> > +               "'<width>x<height>@<rate>', modes are separated by
> colons. (:)");
> > +out:
> > +    g_free(str);
> > +    return;
> > +}
>
>

--0000000000009983f206240bbcdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 4 Oct 2024 at 06:17, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt; This change adds a property &#39;display_modes&#39; on the graphics de=
vice<br>
&gt; which permits specifying a list of display modes. (screen resolution<b=
r>
&gt; and refresh rate)<br>
&gt; <br>
&gt; PCI variant of apple-gfx only for the moment.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-pci.m |=C2=A0 43 ++++++++++-<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 17 ++++-=
<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0| 151 ++++++++++=
++++++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A03 files changed, 198 insertions(+), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m<b=
r>
&gt; index 9370258ee46..ea86a1f4a21 100644<br>
&gt; --- a/hw/display/apple-gfx-pci.m<br>
&gt; +++ b/hw/display/apple-gfx-pci.m<br>
&gt; @@ -16,6 +16,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;apple-gfx.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/pci/pci_device.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/pci/msi.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphic=
s.h&gt;<br>
&gt; @@ -101,6 +102,46 @@ static void apple_gfx_pci_reset(Object *obj, Rese=
tType type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[s-&gt;common.pgdev reset];<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void apple_gfx_pci_get_display_modes(Object *obj, Visitor *v,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Property *prop =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXDisplayModeList *mode_list =3D object_field_pro=
p_ptr(obj, prop);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_get_display_modes(mode_list, v, name, errp);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_pci_set_display_modes(Object *obj, Visitor *v,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Property *prop =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXDisplayModeList *mode_list =3D object_field_pro=
p_ptr(obj, prop);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_set_display_modes(mode_list, v, name, errp);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +const PropertyInfo apple_gfx_pci_prop_display_modes =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =3D &quot;display_modes&quot;,<br>
&gt; +=C2=A0 =C2=A0 .description =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Colon-separated list of display mod=
es; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;width&gt;x&lt;height&gt;@&lt;re=
fresh-rate&gt;; the first mode is considered &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&#39;native&#39;. Example: 3840x216=
0@60:2560x1440@60:1920x1080@60&quot;,<br>
<br>
Please use DEFINE_PROP_ARRAY() instead of inventing your own way to <br>
define an array.<br></blockquote><div><br></div><div>Looks like the ability=
 to specify array properties on the Qemu command line has recently been add=
ed. I&#39;m pretty sure I still need the custom set/get implementations for=
 each array element (display mode) though.<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D apple_gfx_pci_get_display_modes,<b=
r>
&gt; +=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D apple_gfx_pci_set_display_modes,<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +#define DEFINE_PROP_DISPLAY_MODES(_name, _state, _field) \<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP(_name, _state, _field, apple_gfx_pci_prop_d=
isplay_modes, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXDispl=
ayModeList)<br>
&gt; +<br>
&gt; +static Property apple_gfx_pci_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_DISPLAY_MODES(&quot;display-modes&quot;, Ap=
pleGFXPCIState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 common.display_modes),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void apple_gfx_pci_class_init(ObjectClass *klass, v=
oid *data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; @@ -118,7 +159,7 @@ static void apple_gfx_pci_class_init(ObjectClass *=
klass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci-&gt;class_id =3D PCI_CLASS_DISPLAY_OTHER=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci-&gt;realize =3D apple_gfx_pci_realize;<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 // TODO: Property for setting mode list<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, apple_gfx_pci_properties);<b=
r>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static TypeInfo apple_gfx_pci_types[] =3D {<br>
&gt; diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h<br>
&gt; index 995ecf7f4a7..baad4a98652 100644<br>
&gt; --- a/hw/display/apple-gfx.h<br>
&gt; +++ b/hw/display/apple-gfx.h<br>
&gt; @@ -5,14 +5,28 @@<br>
&gt;=C2=A0 =C2=A0#define TYPE_APPLE_GFX_PCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;apple-gfx-pci&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/typedefs.h&quot;<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct AppleGFXState AppleGFXState;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct AppleGFXDisplayMode {<br>
&gt; +=C2=A0 =C2=A0 uint16_t width_px;<br>
&gt; +=C2=A0 =C2=A0 uint16_t height_px;<br>
&gt; +=C2=A0 =C2=A0 uint16_t refresh_rate_hz;<br>
&gt; +} AppleGFXDisplayMode;<br>
&gt; +<br>
&gt; +typedef struct AppleGFXDisplayModeList {<br>
&gt; +=C2=A0 =C2=A0 GArray *modes;<br>
&gt; +} AppleGFXDisplayModeList;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void apple_gfx_common_init(Object *obj, AppleGFXState *s, =
const char* obj_name);<br>
&gt; +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, =
Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, Error **=
errp);<br>
&gt; +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, =
Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, Error **=
errp);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifdef __OBJC__<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;exec/memory.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/surface.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &lt;dispatch/dispatch.h&gt;<br>
&gt; @@ -38,6 +52,7 @@ struct AppleGFXState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool new_frame;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool cursor_show;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QEMUCursor *cursor;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXDisplayModeList display_modes;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dispatch_queue_t render_queue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The following fields should only be acces=
sed from render_queue: */<br>
&gt; diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m<br>
&gt; index 6ef1048d93d..358192db6a0 100644<br>
&gt; --- a/hw/display/apple-gfx.m<br>
&gt; +++ b/hw/display/apple-gfx.m<br>
&gt; @@ -16,6 +16,9 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/console.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt; @@ -23,9 +26,10 @@<br>
&gt;=C2=A0 =C2=A0#include &lt;mach/mach_vm.h&gt;<br>
&gt;=C2=A0 =C2=A0#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphic=
s.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static const PGDisplayCoord_t apple_gfx_modes[] =3D {<br>
&gt; -=C2=A0 =C2=A0 { .x =3D 1440, .y =3D 1080 },<br>
&gt; -=C2=A0 =C2=A0 { .x =3D 1280, .y =3D 1024 },<br>
&gt; +static const AppleGFXDisplayMode apple_gfx_default_modes[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { 1920, 1080, 60 },<br>
&gt; +=C2=A0 =C2=A0 { 1440, 1080, 60 },<br>
&gt; +=C2=A0 =C2=A0 { 1280, 1024, 60 },<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct PGTask_s { // Name matches forward declarat=
ion in PG header<br>
&gt; @@ -264,7 +268,6 @@ static void set_mode(AppleGFXState *s, uint32_t wi=
dth, uint32_t height)<br>
&gt;=C2=A0 =C2=A0static void create_fb(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;con =3D graphic_console_init(NULL, 0, =
&amp;apple_gfx_fb_ops, s);<br>
&gt; -=C2=A0 =C2=A0 set_mode(s, 1440, 1080);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cursor_show =3D true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -466,20 +469,24 @@ static void apple_gfx_register_task_mapping_hand=
lers(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return disp_desc;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static NSArray&lt;PGDisplayMode*&gt;* apple_gfx_prepare_display_mode_=
array(void)<br>
&gt; +static NSArray&lt;PGDisplayMode*&gt;* apple_gfx_create_display_mode_a=
rray(<br>
&gt; +=C2=A0 =C2=A0 const AppleGFXDisplayMode display_modes[], int display_=
mode_count)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];<br>
&gt; +=C2=A0 =C2=A0 PGDisplayMode **modes =3D alloca(sizeof(modes[0]) * dis=
play_mode_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NSArray&lt;PGDisplayMode*&gt;* mode_array =
=3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; display_mode_count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const AppleGFXDisplayMode *mode =3D &amp;=
display_modes[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDisplayCoord_t mode_size =3D { mode-&gt=
;width_px, mode-&gt;height_px };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0modes[i] =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc] init=
WithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc] init=
WithSizeInPixels:mode_size<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 refr=
eshRateInHz:mode-&gt;refresh_rate_hz];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 mode_array =3D [NSArray arrayWithObjects:modes count:AR=
RAY_SIZE(apple_gfx_modes)];<br>
&gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayWithObjects:modes count:di=
splay_mode_count];<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; display_mode_count; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[modes[i] release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0modes[i] =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -516,6 +523,8 @@ static void apple_gfx_register_task_mapping_handle=
rs(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDe=
scriptor *desc)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PGDisplayDescriptor *disp_desc =3D nil;<br>
&gt; +=C2=A0 =C2=A0 const AppleGFXDisplayMode *display_modes =3D apple_gfx_=
default_modes;<br>
&gt; +=C2=A0 =C2=A0 int num_display_modes =3D ARRAY_SIZE(apple_gfx_default_=
modes);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;s-&gt;tasks);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;render_queue =3D dispatch_queue_create=
(&quot;apple-gfx.render&quot;,<br>
&gt; @@ -533,7 +542,127 @@ void apple_gfx_common_realize(AppleGFXState *s, =
PGDeviceDescriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pgdisp =3D [s-&gt;pgdev newDisplayWith=
Descriptor:disp_desc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port:0 serialNum:1234];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[disp_desc release];<br>
&gt; -=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D apple_gfx_prepare_display_mod=
e_array();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;display_modes.modes !=3D NULL &amp;&amp; s-&g=
t;display_modes.modes-&gt;len &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 display_modes =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;g_array_index(s-&gt;di=
splay_modes.modes, AppleGFXDisplayMode, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_display_modes =3D s-&gt;display_modes=
.modes-&gt;len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_create_display_mode_array(displ=
ay_modes, num_display_modes);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create_fb(s);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, =
Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, Error **=
errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GArray *modes =3D mode_list-&gt;modes;<br>
&gt; +=C2=A0 =C2=A0 /* 3 uint16s (max 5 digits) and 3 separator characters =
per mode + nul. */<br>
&gt; +=C2=A0 =C2=A0 size_t buffer_size =3D (5 + 1) * 3 * modes-&gt;len + 1;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 char *buffer =3D alloca(buffer_size);<br>
&gt; +=C2=A0 =C2=A0 char *pos =3D buffer;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 unsigned used =3D 0;<br>
&gt; +=C2=A0 =C2=A0 buffer[0] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 for (guint i =3D 0; i &lt; modes-&gt;len; ++i)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXDisplayMode *mode =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;g_array_index(modes, A=
ppleGFXDisplayMode, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc =3D snprintf(pos, buffer_size - us=
ed,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s%&quot;PRIu16&quot;x%&quot;PRIu16&quot;@%&quo=
t;PRIu16,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 i &gt; 0 ? &quot;:&quot; : &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mode-&gt;width_px, mode-&gt;height_px,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mode-&gt;refresh_rate_hz);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 used +=3D rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pos +=3D rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(used &lt; buffer_size);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pos =3D buffer;<br>
&gt; +=C2=A0 =C2=A0 visit_type_str(v, name, &amp;pos, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, =
Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, Error **=
errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *endptr;<br>
&gt; +=C2=A0 =C2=A0 char *str;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 unsigned int val;<br>
&gt; +=C2=A0 =C2=A0 uint32_t num_modes;<br>
&gt; +=C2=A0 =C2=A0 GArray *modes;<br>
&gt; +=C2=A0 =C2=A0 uint32_t mode_idx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_str(v, name, &amp;str, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 // Count colons to estimate modes. No leading/trailing =
colons so start at 1.<br>
&gt; +=C2=A0 =C2=A0 num_modes =3D 1;<br>
&gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; str[i] !=3D &#39;\0&#39;; ++i)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (str[i] =3D=3D &#39;:&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++num_modes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 modes =3D g_array_sized_new(false, true, sizeof(AppleGF=
XDisplayMode), num_modes);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 endptr =3D str;<br>
&gt; +=C2=A0 =C2=A0 for (mode_idx =3D 0; mode_idx &lt; num_modes; ++mode_id=
x)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXDisplayMode mode =3D {};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mode_idx &gt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*endptr !=3D &#39;:&#39=
;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto separato=
r_error;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++endptr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_strtoui(endptr, &amp;endptr,=
 10, &amp;val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret || val &gt; UINT16_MAX || val =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;widt=
h of &#39;%s&#39; must be a decimal integer number &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;of pixels in the range 1..65535&quot;, name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode.width_px =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*endptr !=3D &#39;x&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto separator_error;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_strtoui(endptr + 1, &amp;end=
ptr, 10, &amp;val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret || val &gt; UINT16_MAX || val =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;heig=
ht of &#39;%s&#39; must be a decimal integer number &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;of pixels in the range 1..65535&quot;, name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode.height_px =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*endptr !=3D &#39;@&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto separator_error;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_strtoui(endptr + 1, &amp;end=
ptr, 10, &amp;val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;refr=
esh rate of &#39;%s&#39;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot; must be a non-negative decimal integer (Hertz)&quot;, =
name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode.refresh_rate_hz =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_array_append_val(modes, mode);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mode_list-&gt;modes =3D modes;<br>
&gt; +=C2=A0 =C2=A0 goto out;<br>
&gt; +<br>
&gt; +separator_error:<br>
&gt; +=C2=A0 =C2=A0 error_setg(errp, &quot;Each display mode takes the form=
at &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&#39;&lt=
;width&gt;x&lt;height&gt;@&lt;rate&gt;&#39;, modes are separated by colons.=
 (:)&quot;);<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 g_free(str);<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +}<br>
<br>
</blockquote></div></div>

--0000000000009983f206240bbcdb--

