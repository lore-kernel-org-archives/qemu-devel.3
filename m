Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9E9C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFMP-00087C-P2; Thu, 07 Mar 2024 10:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1riFMN-00086y-VH
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:08:39 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1riFMH-0003Xt-BA
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
 :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h5ju99t+Idr1MInJaq3xmNrCIV4J4/IqAe6/w/DoVTE=; b=lbUQYrF3L53rv8xBwJLheISWY3
 M5YY/a17mpNf1PRw3sjs8m6ilsyDcgE4PDSYuV8v8bf/XwGIU5rx+ZGuJySNd3PuEHtolQ5FvoHVz
 5X16HG92f6d1ibwI9zEY/o/MZXLWhBhxkMFLlYG/aQW0iYO6rhVT4FgTg9T5p5bUq3cBenrOQ4iRk
 jHH6tyOCr/8+GekPvQMx41FVoUqi6foXrz3x0HcvoUyPGHtorXF3MzE98oyWFqEuIbx0H4BHq3PNi
 y04BmnofgKjWdP8zbIE43dizG5NY/cHEUwLiW0Z81PxXcLBoaN8xj8Wuk6SfrWGU/KUPD1z305tIu
 vZNUezOQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1riFMC-00BYvS-2R;
 Thu, 07 Mar 2024 15:08:28 +0000
Date: Thu, 7 Mar 2024 15:08:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, berrange@redhat.com
Subject: Re: [PATCH] hmp: Add option to info qtree to omit details
Message-ID: <ZenYbJW3K6WiiYMI@gallifrey>
References: <20240301181229.332754E602B@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240301181229.332754E602B@zero.eik.bme.hu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 15:07:33 up 64 days, 17:57,  2 users,  load average: 0.06, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* BALATON Zoltan (balaton@eik.bme.hu) wrote:
> The output of info qtree monitor command is very long. Add an option
> to print a brief overview omitting all the details.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Seems OK to me (I'm not sure I'd have both 'brief' and 'detailed',
but rather stick to one or the other as variable names); still:

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hmp-commands-info.hx  |  6 +++---
>  system/qdev-monitor.c | 24 +++++++++++++-----------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index da120f82a3..ad1b1306e3 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -540,9 +540,9 @@ ERST
>  
>      {
>          .name       = "qtree",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show device tree",
> +        .args_type  = "brief:-b",
> +        .params     = "[-b]",
> +        .help       = "show device tree (-b: brief, omit properties)",
>          .cmd        = hmp_info_qtree,
>      },
>  
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index a13db763e5..d5cef36800 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -744,7 +744,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  }
>  
>  #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
> -static void qbus_print(Monitor *mon, BusState *bus, int indent);
>  
>  static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
>                               int indent)
> @@ -784,13 +783,9 @@ static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int ind
>  static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>  {
>      ObjectClass *class;
> -    BusState *child;
>      NamedGPIOList *ngl;
>      NamedClockList *ncl;
>  
> -    qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
> -                dev->id ? dev->id : "");
> -    indent += 2;
>      QLIST_FOREACH(ngl, &dev->gpios, node) {
>          if (ngl->num_in) {
>              qdev_printf("gpio-in \"%s\" %d\n", ngl->name ? ngl->name : "",
> @@ -814,12 +809,9 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>          class = object_class_get_parent(class);
>      } while (class != object_class_by_name(TYPE_DEVICE));
>      bus_print_dev(dev->parent_bus, mon, dev, indent);
> -    QLIST_FOREACH(child, &dev->child_bus, sibling) {
> -        qbus_print(mon, child, indent);
> -    }
>  }
>  
> -static void qbus_print(Monitor *mon, BusState *bus, int indent)
> +static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
>  {
>      BusChild *kid;
>  
> @@ -827,16 +819,26 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)
>      indent += 2;
>      qdev_printf("type %s\n", object_get_typename(OBJECT(bus)));
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        BusState *child_bus;
>          DeviceState *dev = kid->child;
> -        qdev_print(mon, dev, indent);
> +        qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
> +                    dev->id ? dev->id : "");
> +        if (details) {
> +            qdev_print(mon, dev, indent + 2);
> +        }
> +        QLIST_FOREACH(child_bus, &dev->child_bus, sibling) {
> +            qbus_print(mon, child_bus, indent + 2, details);
> +        }
>      }
>  }
>  #undef qdev_printf
>  
>  void hmp_info_qtree(Monitor *mon, const QDict *qdict)
>  {
> +    bool brief = qdict_get_try_bool(qdict, "brief", false);
> +
>      if (sysbus_get_default())
> -        qbus_print(mon, sysbus_get_default(), 0);
> +        qbus_print(mon, sysbus_get_default(), 0, !brief);
>  }
>  
>  void hmp_info_qdm(Monitor *mon, const QDict *qdict)
> -- 
> 2.30.9
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

