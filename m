Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DA8C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8en-0003Wu-DF; Thu, 20 Feb 2025 10:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8el-0003T8-2t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8ej-0002wW-7U
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740066002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZN/bBhv9RWLgStCo3Ix/B0E/Wdr9j7bLULVSoLuT++8=;
 b=HIklzVEqL8WBGHldFqEVEEmtS1y29gWOBsKLBq8qNZfi9ICLQpy6a0b039SHIzuXigsshM
 aZKy/wfqKfRbvTqv7lve0J5t4tpDSm2GYvH0AaaFgMoKyp73xqQXqHxo8t9CmbGCeF24Rp
 ZdgQ02ICFxeTfOqKOyxiIi1V9vVRKE0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-BYH2c7qJN7uX3P6Yl1MA4w-1; Thu, 20 Feb 2025 10:40:01 -0500
X-MC-Unique: BYH2c7qJN7uX3P6Yl1MA4w-1
X-Mimecast-MFC-AGG-ID: BYH2c7qJN7uX3P6Yl1MA4w_1740066000
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d9fb24f87bso2557404a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065999; x=1740670799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN/bBhv9RWLgStCo3Ix/B0E/Wdr9j7bLULVSoLuT++8=;
 b=IlaYtJeI7jqelWMPW2IfD5LsQZRKNUZnJC2nt5R+qhvkd6FA1xH8ntaEu6B7MNJD0o
 DQuwUT9j4OobxoLbnP30AHQdfutD3iDmENagVmyLSdsIUajYl1mGEzTyyM6HdyBBoRpu
 ih/x9iEZY0PjFyEub1hKJUI+dVtlXsPYxZAzU4witPwvzdtiZpHx40XgJJJsWRi/XKvL
 4VYd4DUS6wY4DX2XME2KBytR+LqeaNvM2oAcB7kSjogjq288MjBqEMELYrlIwqJC1imo
 hV1P5Uau3ncg59KpyACPtAtFDCr755WXcGWKdrHJWSbqWnWsvGUg7K1EdVF9zFLBgZ5C
 I9aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGbwQiYF21FyilvCHZZkS5Cx8DPV3G5HDGXCDJc2tphbqEWAZYhe/FfqeF2X5m3ERv9PQS1+9GtXkh@nongnu.org
X-Gm-Message-State: AOJu0Yxe7AxuOG6Zw8cFcFJX3AnfS3KSFM05QtRbL12CfFiqqABdrpZD
 I7ql2yK3c29W5msu60IjgwjwVON5w2FwrQSMxfMrqBDX4UIdt/rRVceGqk9peyDK0DBqPxO/3o3
 KPoTRwQiB1yHdC9phR65i+6iS5Qlnvpv7m5A1IePKvp8FShXry2UP
X-Gm-Gg: ASbGncsxO0At5ynHd/oQBRk8QSCcpuuET5/e8FUipbYWsYoAwF+/D1vsoLRZ9RWjitz
 /b8WzPZxJv2jOw1uIbmbPwpb+o/KVbW6byMi3yPloWhTyuEJ7157QOD//rpB8uNRwiSHXD+R58V
 dElfiZ92Wve3qKKq8aC6XwwxwWY1Xc+Wymo4Y6w5lqmDSpD+N46rtoGeF5Y5PeKC2ckYVQJvBxQ
 LbghrIhX9Z5zOe6UhKGEUCppRFI7o5g6UIzOqq3K3aUryH0UNXYMGVweC7EVPWaE5ZQAQ==
X-Received: by 2002:a05:6402:2347:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e089cff4bcmr8154854a12.25.1740065997502; 
 Thu, 20 Feb 2025 07:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQRlsLlk7u00eOU9XQbyVEpbJX39oa2zZQFp24quK7nKrsNg3uVLYeCg/COf7xRIhsTLzK5A==
X-Received: by 2002:a05:6402:2347:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e089cff4bcmr8154721a12.25.1740065995606; 
 Thu, 20 Feb 2025 07:39:55 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e99sm12156368a12.16.2025.02.20.07.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:39:54 -0800 (PST)
Date: Thu, 20 Feb 2025 10:39:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] qom: Use command line syntax for default values in help
Message-ID: <20250220103935-mutt-send-email-mst@kernel.org>
References: <20250207-bool-v1-1-5749d5d6df24@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-bool-v1-1-5749d5d6df24@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Feb 07, 2025 at 02:53:43PM +0900, Akihiko Odaki wrote:
> object_property_help() uses the conventional command line syntax instead
> of the JSON syntax. In particular,
> - Key-value pairs are written in the command line syntax.
> - bool description passed to the function says on/off instead of
>   true/false.
> 
> However, there is one exception: default values are formatted into JSON.
> While the command line and JSON syntaxes are consistent in many cases,
> there are two types where they disagree:
> 
> string: The command line syntax omits quotes while JSON requires them.
> 
> bool: JSON only accepts true/false for bool but the command line syntax
>       accepts on/off too, and on/off are also more popular than
>       true/false. For example, the docs directory has 2045 "on"
>       occurances while it has only 194 "true" occurances.
>       on/off are also accepted by OnOffAuto so users do not have to
>       remember the type is bool or OnOffAuto to use the values.
> 
> Omit quotes for strings and use on/off for bools when formatting
> default values for better consistency.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>




> ---
>  qom/object_interfaces.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 1a6f29c053e45bf5da5252f6ac1dfa4e85627f9f..f2450f8099c366864b56940e19c6a4bcc0d5e3a9 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -4,9 +4,11 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-qom.h"
>  #include "qapi/qmp/qobject.h"
> +#include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qstring.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qom/object_interfaces.h"
> @@ -177,9 +179,25 @@ char *object_property_help(const char *name, const char *type,
>          g_string_append(str, description);
>      }
>      if (defval) {
> -        g_autofree char *def_json = g_string_free(qobject_to_json(defval),
> -                                                  false);
> -        g_string_append_printf(str, " (default: %s)", def_json);
> +        g_autofree char *def_json = NULL;
> +        const char *def;
> +
> +        switch (qobject_type(defval)) {
> +        case QTYPE_QSTRING:
> +            def = qstring_get_str(qobject_to(QString, defval));
> +            break;
> +
> +        case QTYPE_QBOOL:
> +            def = qbool_get_bool(qobject_to(QBool, defval)) ? "on" : "off";
> +            break;
> +
> +        default:
> +            def_json = g_string_free(qobject_to_json(defval), false);
> +            def = def_json;
> +            break;
> +        }
> +
> +        g_string_append_printf(str, " (default: %s)", def);
>      }
>  
>      return g_string_free(str, false);
> 
> ---
> base-commit: 7433709a147706ad7d1956b15669279933d0f82b
> change-id: 20250207-bool-967267fd0a25
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


