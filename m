Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09738E91269
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 06:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnt7m-0008QB-5W; Thu, 05 Feb 2026 01:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnt7k-0008Pw-Ti
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnt7j-0004PV-2A
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770273954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLyvMAy5/GdRTWJQIbbj4+28MohoIezOkflqda7VMDg=;
 b=A2QGc6/1Ecj8EtTiBj9f4iVKItCQZZ83x2rTdZafK3+CcpCqhfF1ND5nzU/vKSDVygwECw
 n1F77lRrDEkWhhghkzmlGENPaKH7ltpmT5hkkLV2UOXWcfCz9NWsSOak7beO9eD1R9e7tC
 UTTDB+pEjvkXe4nkI4d8T7lLtyKDT7o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-6uQRDtaJNQGr9NP0QK-qbQ-1; Thu, 05 Feb 2026 01:45:53 -0500
X-MC-Unique: 6uQRDtaJNQGr9NP0QK-qbQ-1
X-Mimecast-MFC-AGG-ID: 6uQRDtaJNQGr9NP0QK-qbQ_1770273952
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43623cfb160so141581f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 22:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770273951; x=1770878751; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uLyvMAy5/GdRTWJQIbbj4+28MohoIezOkflqda7VMDg=;
 b=XK1F+9xFkEFrtGjfyRwXRwbsMPoQcQFd7e+FNqAZ2chRy0bOQNdM6DBRiCxQB8X2OL
 cwDI9LJjpAKWCiyFle2IZi/ZLv4Bwn6/C+zWlNHIa9TQ1g1VUVN2wniv9KUmpYgvNIuZ
 znwoavgi7dwERHyQY6Hke5JwQkLZo+7NZ7MaYXrlOzoGmpGndRYGDBnET0ldKtx12YYN
 zCENQpj973kGxG+LOg3WsOkh0EztMgf+1C29SRM1NrKj2CNb4xIMTh2UMeOTuMleeX++
 hxD1m8bHeY4tuStSreJDWJAUZmMYwJ8gyPkywHbqQhnSIenRpGQ2lrIm0bUtYlM7pXdx
 G6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770273951; x=1770878751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLyvMAy5/GdRTWJQIbbj4+28MohoIezOkflqda7VMDg=;
 b=GuyAfbpvuHQ15QhndGrTqtTRrjzLhXbsCf4kSZze9zd2x/9kNo8JKS8oFm2PNEMU+H
 gDfqcvLko3ognanDQyd8wx0tTWWoxa1i9WwGubrN1dq+27OffPqcdNMEjsQ8/qMopoAj
 2aGBkVvzKUM3heWNnJJ4m6epqDxMkKR+iAKyO2CiPo5XnsRBCIJh0SlVOPMSBvRI+dX1
 P7qTZ4xZb0khyk42SEm89HGTBomgbUYMFoedCT4oq+PX9rhKtGoU5s9NY/eg2pkOfnbj
 UOQ2VQUu4jYluLr9vwIx047XyUpcnGCYr6GWJ3d9ZjBtsX2d85mb7z4McmLU+fZuwipr
 lVgw==
X-Gm-Message-State: AOJu0YxL2iK7Quxrnx64em2XHxpgcl+VZa9QFmdQuC32Ld8pjRtBRsKE
 48L/pK7SDVy9C+kCtGQkJMyPUlXbDX0fGzlJ64jt4/ZgQjQEukUW8F+ImBzYez2B9HVMRFftWZh
 WNJ0zf+B0BRXImb1Nr+LdvvUiRtIyev5039uoAeH09L4DJMMHizmmNH0xk6RdvKw5TwUv6KFBC2
 zgZa8dtQkoA1bzKKrvcFB+hS8nAptJFUz6Sg==
X-Gm-Gg: AZuq6aJHRicIULvSABpmYTBE42f8oPtb0YtVm4divQ9o9fKuYvIHJuQGaz4k/Tq9oy2
 qDaOmFt1dJINoS9tzvDXESwwF1CCSNjPi2SrlF3OXQeS/Cw72TSVMq2VhkBKvOr9O8M8g+H+MR/
 XJwF+9rmFPkeZOhLY4W8ijYYKPXGH0XQlhp2xHrk1O9SF8TJuu7Kyf0DQh35txfCnuMWX/LTx66
 7jo86ICyyLNAf4VbyfZN6Wd83InIo65tI3QH1sGcL3e/JBISNG54t8KoX98ginJrme5uN52g8vM
 R85ZIM08OkgsEcFKB5VRRvEfpKWZZfT27Vg+IEdfNRQ+DYfcKgi8pSIScYfMGg5/BTIdBehh7E/
 XbsialaREi9PJpmxAFnzB3aVm62SgNwN4pw==
X-Received: by 2002:a05:600c:4fc4:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-4830e95d692mr75610405e9.16.1770273951421; 
 Wed, 04 Feb 2026 22:45:51 -0800 (PST)
X-Received: by 2002:a05:600c:4fc4:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-4830e95d692mr75609925e9.16.1770273950858; 
 Wed, 04 Feb 2026 22:45:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fc0a3bbsm69035585e9.1.2026.02.04.22.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 22:45:50 -0800 (PST)
Date: Thu, 5 Feb 2026 01:45:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 05/51] qapi: cxl: Refactor CXL event injection for common
 commands arguments
Message-ID: <20260205014516-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <785b458d94343c629d353628f9cf6e5774dbc2f6.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785b458d94343c629d353628f9cf6e5774dbc2f6.1770231744.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 02:03:02PM -0500, Michael S. Tsirkin wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Refactor CXL event injection to use struct for common command
> arguments.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20260114142713.617806-2-Jonathan.Cameron@huawei.com>


I dropped this and the following 4 patches since there's a
new version under review now.

> ---
>  qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 31 deletions(-)
> 
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index eeddb58d1d..55a088586e 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -31,11 +31,10 @@
>   }
>  
>  ##
> -# @cxl-inject-general-media-event:
> +# @CXLCommonEventBase:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> -# specified via the log parameter.
> +# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> +# Table 8-42 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
> @@ -44,6 +43,16 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# Since: 8.1
> +##
> +{ 'struct': 'CXLCommonEventBase',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +
> +##
> +# @CXLGeneralMediaEvent:
> +#
> +# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,26 +83,29 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLGeneralMediaEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>  
>  ##
> -# @cxl-inject-dram-event:
> +# @cxl-inject-general-media-event:
>  #
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> -# This event type is reported via one of the event logs specified via
> -# the log parameter.
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# logs specified via the log parameter.
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': 'CXLGeneralMediaEvent' }
> +
> +##
> +# @CXLDRAMEvent:
>  #
> -# @log: Event log to add the event to
> -#
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> @@ -133,9 +145,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLDRAMEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> @@ -143,18 +155,21 @@
>             }}
>  
>  ##
> -# @cxl-inject-memory-module-event:
> +# @cxl-inject-dram-event:
>  #
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> -# at the time of the event.
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': 'CXLDRAMEvent' }
> +
> +##
> +# @CXLMemModuleEvent:
>  #
> -# @log: Event Log to add the event to
> -#
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
>  #
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
> @@ -185,9 +200,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> -            'type': 'uint8', 'health-status': 'uint8',
> +{ 'struct': 'CXLMemModuleEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
> @@ -195,6 +210,18 @@
>              'corrected-persistent-error-count': 'uint32'
>              }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0
> +# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> +# at the time of the event.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': 'CXLMemModuleEvent' }
> +
>  ##
>  # @cxl-inject-poison:
>  #
> -- 
> MST
> 


