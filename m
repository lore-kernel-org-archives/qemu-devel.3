Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD658C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYw0-0005L6-E7; Thu, 01 Feb 2024 10:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYvy-0005IC-TW
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:24:58 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYvs-0006Uj-Ft
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:24:57 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so1503591a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706801091; x=1707405891; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PITD+fCruBbKJL9WGFStG0Xh2YCHJSktby9ovEWQQGg=;
 b=baXX/iCQLgAmkKvxj3B8xaieZN1uGIy39R71dlA0a9owJYOpPmd6tYNyKOHr968js9
 cq39hV8RTgXdyiOsTyp8xb8PijgElorQOohFlvVdOeQYHH2NpZZ3KwsjJVASjF92NUvI
 MWvPJlIp7aiQU2lhHdaJOQbZJ8OCVUbnPeO1h44cuhqfbbTKT7MqAmNZerxjVKEolaga
 QWoGuywZM6bwuol8njEC3r2nSCAzDn4rxKQQOTFvxyNlutjQNpwRWTUVQCA1aNsFEeeA
 gcUtYrSm4CWd+FjrZ4bQt/8kK2foL9NE4i4LHEOqhLSGm6v5vm/kQbPnsfiqNhJ6pRew
 af7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706801091; x=1707405891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PITD+fCruBbKJL9WGFStG0Xh2YCHJSktby9ovEWQQGg=;
 b=bfjwim3OXAUVnm3kkx9CKDOXNcarf/g9fCxA5O+xMY/8papqanbLoRiL10yMq2ojkz
 2TPi0FWeDCQ9sNc1RVyoOmaifV/9V9HlPpUqeJ60kfUD4EcNjLiqQN4xEZPLFhRTwtfT
 LdkvTV4Z8O+pF/vGCT3AYTUCDsZDp9mcCoBWNM2XWp8P/4lYAQxvt0dOM0g9nTTo6WOo
 OxNKw+2A7ENTAXr68MpVwSSm3r6V7OwIieN2e2EEENgD6u0puVWY09oBpu/1P3o9E56H
 QmHPJACvqVUVyv0VWTNYR6zEvcrdDtCAowzjb7B9DBpRoAc29L4hlQNHhXDaHyPF8Gdw
 oDNg==
X-Gm-Message-State: AOJu0YwbwrBgVgh7xvubu11gHiZJLavwYIKMYwVXnaxhPDOWMErA4POM
 s22F7w2w7lrKaMiv5YCCB2HcNSpDRcHGSTVbANBK9HMe0jaSJn5fkAL56g6NMBp1xvxeLJQ5/CH
 bvxiulBZs9nsfeU/k50ZfGeLWUDoWS7fXl4d2K5xAQOeDgVQG
X-Google-Smtp-Source: AGHT+IEJwZoEp8lf1iAd5kJWOghwlQop5dFyOE6Jqld3zxLokrGrKXmygih7QAlU9SHLT73MwFATF6AlUxiR1O5Rd7Q=
X-Received: by 2002:a05:6402:142:b0:55e:ec49:7aac with SMTP id
 s2-20020a056402014200b0055eec497aacmr3471596edu.40.1706801090822; Thu, 01 Feb
 2024 07:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
 <20240126005541.1839038-2-komlodi@google.com>
In-Reply-To: <20240126005541.1839038-2-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 15:24:40 +0000
Message-ID: <CAFEAcA9xf3WvNPiTp2LRP_8Tuv=KDGMLDSwOtD+S0UDK5UVDZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/i2c: core: Add reset
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 26 Jan 2024 at 00:56, Joe Komlodi <komlodi@google.com> wrote:
>
> It's possible for a reset to come in the middle of a transaction, which
> causes the bus to be in an old state when a new transaction comes in.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/i2c/core.c        | 30 +++++++++++++++++++++++++-----
>  include/hw/i2c/i2c.h |  6 +++++-
>  2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..def4f134d0 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -23,11 +23,31 @@ static Property i2c_props[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> -static const TypeInfo i2c_bus_info = {
> -    .name = TYPE_I2C_BUS,
> -    .parent = TYPE_BUS,
> -    .instance_size = sizeof(I2CBus),
> -};
> +static void i2c_bus_enter_reset(Object *obj, ResetType type)
> +{
> +    I2CBus *bus = I2C_BUS(obj);
> +    I2CNode *node, *next;
> +
> +    bus->broadcast = false;
> +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> +        QLIST_REMOVE(node, next);
> +        g_free(node);
> +    }

Doesn't it confuse the device that's partway through a
transaction if we just forget about the transaction entirely
without terminating it somehow? I'm not sure what real hardware
does in this situation, though.

> +}
> +
> +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    rc->phases.enter = i2c_bus_enter_reset;
> +}
> +
> + static const TypeInfo i2c_bus_info = {
> +     .name = TYPE_I2C_BUS,
> +     .parent = TYPE_BUS,
> +     .instance_size = sizeof(I2CBus),
> +     .class_size = sizeof(I2CBusClass),
> +     .class_init = i2c_bus_class_init,
> + };

Looks like you have stray extra spaces in front of this
type definition (which has then caused 'diff' to not notice
that you're only adding fields to the existing struct).

>
>  static int i2c_bus_pre_save(void *opaque)
>  {
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 2a3abacd1b..420868a269 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -64,7 +64,7 @@ struct I2CSlave {
>  };
>
>  #define TYPE_I2C_BUS "i2c-bus"
> -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
>
>  typedef struct I2CNode I2CNode;
>
> @@ -83,6 +83,10 @@ struct I2CPendingMaster {
>  typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
>  typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingMasters;
>
> +struct I2CBusClass {
> +    DeviceClass parent_class;
> +};

This isn't correct -- a FooBusClass's parent_class field
should be a BusClass. But since you don't define any new
fields in it, you don't need to define the struct at all.

Instead, your TypeInfo for the TYPE_I2C_BUS can add a
.class_init member, and leave the .class_size unset
(it will then inherit the class-size from the parent
class, which will be sizeof(BusClass)).

> +
>  struct I2CBus {
>      BusState qbus;
>      I2CNodeList current_devs;
> --
> 2.43.0.429.g432eaa2c6b-goog

thanks
-- PMM

