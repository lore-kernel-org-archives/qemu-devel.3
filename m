Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C77C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 08:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tirSO-0003LF-Bp; Fri, 14 Feb 2025 03:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tirSM-0003L7-CG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 03:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tirSK-0008BC-5i
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 03:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739523226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQpuYQ79X10itpu1JqdcJ5blnxANd4hBsBq15dJniv0=;
 b=d2z+jtaAHGnLG6i/pP0jW0+B1bKVMxFiuOyYD31MBDZziK0JXtsdX+OhyvPin6RhEQMuvS
 QpIlLvacuUB9IvphlY5hdyYh1ct6mm3W7V/vR3spmL7e8qWRSoW+PzsFIVt+7+FnF0TBfK
 V2hHI2e2dPnMfvLLA4u/iWMeOW2ZMnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-kj6Ay3wrMm6tzHjO9bkg2Q-1; Fri, 14 Feb 2025 03:53:45 -0500
X-MC-Unique: kj6Ay3wrMm6tzHjO9bkg2Q-1
X-Mimecast-MFC-AGG-ID: kj6Ay3wrMm6tzHjO9bkg2Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43961fb0bafso8840665e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 00:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739523223; x=1740128023;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQpuYQ79X10itpu1JqdcJ5blnxANd4hBsBq15dJniv0=;
 b=c79kmqIFZOVhZKWHgXi0EMyQnTfaVg+Hjlu1mZDLUdks+oO3fkgQUmPakD1lJfFHKh
 4lkUxAjceNUHQjfuNXnoehpl4Bd4iv23CQ3IUQxg4rTAqvCE0VcH/4r75DNLN5UNH7aF
 4TcY/HXW5Mkw1MwdRsHW/u+xEW00b5VSbKwCL7LFJBcL7qhXrmSX+xtugMbXLlP5J1GI
 OzYA9bRB9417KnQMg3EeHKHhAJkDZYmJ1mjZBTuwce5guZgVxaJkA8qwb0ZD6KzTs8M0
 /Mp3K4s8NTBpZ3nzKQULhgQJwdRPS3aSVxC7GYDO3QDtkM5GpTpMiPJu4zINsXVg0OAN
 F+vw==
X-Gm-Message-State: AOJu0Yx1qCLmY4M30eP+NFejJqpjEnqtHZ0LTGUWZEjkxLfMEnjqK/s8
 M2oyEhBAwbopG989RYQBoWUUdmrQ/RZTBilIZcvjzm1+k/XPs05MWefAOJh+ciYTJL6kCUQ77HP
 K7yKWqiWWsXd4NQvJ/j0Iusz8sEsp1NoG5dKm+ZYbor33QBq40Ow0AtPPsTDDEK0JddSxbZmC7r
 9msWuXonhamOZW0SZ9qYQuZYhXS4Sozx++eoA=
X-Gm-Gg: ASbGncsWsUpJQM2EEWX2fnoeVuZN+LIXScKzBGrG13rJFSWhebH+SXodgKpoOyoWx8y
 nb/aOpZUvLt1mnlL4Msdlfbcma54Nt5TuGPY+vmWBkWNGmAbElSdG1ibTPhxVm7kKHpD0KRVJa7
 a6FQZ+ofSBOrUAMWPn4udZ2Mo2DWpzw6JLMx460WUG0ujFhVTe4F9Lkl/jJjpWVPAjTHKw5H4qn
 1z5lA4oO1RFOdLs7x09yiwmJbZ5GM7Z8fF5wWcjpoc6esHOYRfEi+rY6UfQ1QxHIKsVTDVHQ96r
 2wVm2VZYCxJ7oyyxVvuSMJFVfatvDg1Vxg==
X-Received: by 2002:a05:600c:1912:b0:439:5757:daf2 with SMTP id
 5b1f17b1804b1-439601692damr85941435e9.6.1739523222847; 
 Fri, 14 Feb 2025 00:53:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEposDSXc+AS0Jm3Ae5f4BmHVdgPF3iH+LR9Cg/+Q0lKGAc6dauH85JWXRDTtGG7PquPekHhA==
X-Received: by 2002:a05:600c:1912:b0:439:5757:daf2 with SMTP id
 5b1f17b1804b1-439601692damr85941105e9.6.1739523222422; 
 Fri, 14 Feb 2025 00:53:42 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913eb6sm4076363f8f.51.2025.02.14.00.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 00:53:41 -0800 (PST)
Date: Fri, 14 Feb 2025 09:53:38 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric
 Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <20250214095338.344063fa@elisabeth>
In-Reply-To: <20250214072629.1033314-1-lvivier@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 14 Feb 2025 08:26:25 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> when it is disconnected.
> 
> The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> (label, filename and frontend_open).
> 
> This allows a system manager like libvirt to detect when the server
> fails.
> 
> For instance with passt:
> 
> { 'execute': 'qmp_capabilities' }
> { "return": { } }
> 
> [killing passt here]
> 
> { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
>   "event": "NETDEV_VHOST_USER_DISCONNECTED",
>   "data": { "netdev-id": "netdev0" } }
> 
> [automatic reconnection with reconnect-ms]
> 
> { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
>   "event": "NETDEV_VHOST_USER_CONNECTED",
>   "data": { "netdev-id": "netdev0",
>             "info": { "frontend-open": true,
>                       "filename": "unix:",
>                       "label": "chr0" } } }
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Tested-by: Stefano Brivio <sbrivio@redhat.com>

...with libvirt's branch from:

  https://gitlab.com/lainestump/libvirt/-/tree/network-passt+vhostuser

simply wiring NETDEV_VHOST_USER_DISCONNECTED to the event handler
qemuMonitorJSONHandleNetdevStreamDisconnected(), that is, the handler
for NETDEV_STREAM_DISCONNECTED. I terminate passt, and it restarts.

-- 
Stefano


