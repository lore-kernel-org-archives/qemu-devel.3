Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56489C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb98B-0000BQ-9h; Fri, 16 Feb 2024 20:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rb989-0000AZ-Cs
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 20:04:37 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rb985-0005MV-I4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 20:04:37 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6e2e42fb159so1214864a34.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 17:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708131872; x=1708736672; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxypKfwz1nWInwHTT7q31WH9T1k/8244u0yq+eE8rPc=;
 b=IgTz9kE6leC5Z1+zehuoaRk9l4CgG3a8t3BkGMfkpqeOVMKhiZsWavBkgsw0ogxU8H
 lnWNCPAzHG4Tr0sqMteyv1DlnZKsWQ/+uZCiKOk30brrLXjeEx8NhikmOtdpPSyphGi3
 nYCeRTXgjAAsRcTtC7tmBmLe1trtf9vtk0gfPBklia9pfMF700D1H68n4GTv1GRgWbb3
 ggm+qjXl50d2o6cjHqqQBH37ydW0ZGT/wX24xyS6uTYqnuJcIS5d3YWpPYG7xO/6ayIe
 N845Z7l+8W5qSMtfcjPgANXysiJXi94YuylZptB4D0qb2RW02fnvtew1Sfc6uhJ7g5H8
 nGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708131872; x=1708736672;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxypKfwz1nWInwHTT7q31WH9T1k/8244u0yq+eE8rPc=;
 b=ngC0Zl+gkiY/pt67rwvokqvG2zo5Lrv/z0xb4/k/poaGtRf0g62Bnhrb1pVNaqM0Qv
 IvPUfnBVLgNPpgFASZD4xsZYc7Jfjnyzu0bR3suYXmKXTso6U/VMYWEdMdXxDumOkm0J
 Mm1E9kM5gD60P0i2fI4Hod0oNv9on0/X+BqVR95Pn3MA3hANqDVwtscLpHjknCa6b/QC
 g59kz1wSpyz9G/euSkUB17s5VM1vV3zEA3lkQW9G52iKV1rAuMWOcVj1h0RPCxFD9ay2
 7fwdiC8bQakOiqTGU6XtZbJNt6HESXd46UK07aurBk5gVjN8sajmDFnnQkdcjaQKpX6Q
 IZ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGNgozEMsAKw/CYQ2BFxRO6MkTlL5E52jj821KNSeOn6j6KJjXBUdFQdvHv/9uX8qsR40vJ/bDAwPP5RIssn5uU/taw1c=
X-Gm-Message-State: AOJu0YyUJ1omglxG/8l4BpNELgHjXRZ8vKzeMgChmEZTdTuZzqpd2EL+
 x2t6TT9FjDyvzJ1V05n1PpMn1IyJZRGBAQghpfJvDKbQlmeXzmc=
X-Google-Smtp-Source: AGHT+IEbVIsU+UXdOzHIdhe78HOQITOEVDCN+Qn1dFPI0eJop/URsIP73eBQlehSezlKCFUhPIddzA==
X-Received: by 2002:a05:6870:a101:b0:21e:8133:755f with SMTP id
 m1-20020a056870a10100b0021e8133755fmr1672512oae.1.1708131871831; 
 Fri, 16 Feb 2024 17:04:31 -0800 (PST)
Received: from serve.minyard.net ([47.184.181.2])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a9d7682000000b006e2ea96949csm181949otl.29.2024.02.16.17.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 17:04:30 -0800 (PST)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:f16d:b49:a339:b48b])
 by serve.minyard.net (Postfix) with ESMTPSA id 76B281800BF;
 Sat, 17 Feb 2024 01:04:30 +0000 (UTC)
Date: Fri, 16 Feb 2024 19:04:29 -0600
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH v3 1/3] hw/i2c: core: Add reset
Message-ID: <ZdAGHThxd2JSyX7b@mail.minyard.net>
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-2-komlodi@google.com>
 <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 08, 2024 at 04:39:10PM +0000, Peter Maydell wrote:
> On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
> >
> > It's possible for a reset to come in the middle of a transaction, which
> > causes the bus to be in an old state when a new transaction comes in.
> >
> > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > ---
> >  hw/i2c/core.c        | 19 +++++++++++++++++++
> >  include/hw/i2c/i2c.h |  2 +-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> > index 4cf30b2c86..3128067bba 100644
> > --- a/hw/i2c/core.c
> > +++ b/hw/i2c/core.c
> > @@ -23,10 +23,29 @@ static Property i2c_props[] = {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > +static void i2c_bus_hold_reset(Object *obj)
> > +{
> > +    I2CBus *bus = I2C_BUS(obj);
> > +    I2CNode *node, *next;
> > +
> > +    bus->broadcast = false;
> > +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> > +        QLIST_REMOVE(node, next);
> > +        g_free(node);
> > +    }
> > +}
> 
> This does what it says it's going to do; but I think it
> would be good to hear from Corey whether it's better to
> do this, or instead to call i2c_end_transfer() in the
> reset-enter phase.

Sorry, I missed this, I'm having major chaos going on right now in my
life.

I don't think i2c_end_transfer() is the right thing to do.  The transfer
has not cleanly ended, it is just forgotten.

> 
> Mostly QEMU's "reset" is like power-cycling, in which case
> I guess that what we have here where we just forget about
> the in-progress transfer and assume the device on the other
> end is also going to reset back to a neutral state is what
> we want.
> 
> Does i2c have a concept of a bus-level "reset" operation?

No, it does not.  Most I2C devices don't even have a reset pin.  In a
reset situation in real hardware, the operation would be aborted by
the lines drifting high after the bus master has been reset.

So I think this is fine as is.

-corey

> 
> > +
> > +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> > +    rc->phases.hold = i2c_bus_hold_reset;
> > +}
> > +
> >  static const TypeInfo i2c_bus_info = {
> >      .name = TYPE_I2C_BUS,
> >      .parent = TYPE_BUS,
> >      .instance_size = sizeof(I2CBus),
> > +    .class_init = i2c_bus_class_init,
> >  };
> 
> 
> 
> >  static int i2c_bus_pre_save(void *opaque)
> > diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> > index 2a3abacd1b..49580e30e2 100644
> > --- a/include/hw/i2c/i2c.h
> > +++ b/include/hw/i2c/i2c.h
> > @@ -64,7 +64,7 @@ struct I2CSlave {
> >  };
> >
> >  #define TYPE_I2C_BUS "i2c-bus"
> > -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> > +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
> 
> I don't think you need this change any more ?
> 
> thanks
> -- PMM
> 

