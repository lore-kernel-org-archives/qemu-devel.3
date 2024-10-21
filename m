Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53C5D15DB4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ubU-0008Ij-2B; Mon, 21 Oct 2024 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2ubR-0008Gf-H4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2ubP-0008Du-5s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729525549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYeZsNInzGHmjRXw3GABtoyBiH6h2R4VP3kWoaBXn8g=;
 b=AVnvpoTfhVo4YDeP5NFH8RYQhYmpcjLUV0CFr/XVrnnBob9oK/ACuVzCXONTPObbxCaRYq
 SAiXbjrYX+zixhkDQs6ZMH2PmTXiG+YI0hAI7aR4QLtx1xbCRvlW0wohbrP2UCTOPX1UUp
 FOL8NNMTvjwJNdW/nqtfSLpsILLWWpo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-E9vTQMLaOZSkVALKnbEShA-1; Mon, 21 Oct 2024 11:45:48 -0400
X-MC-Unique: E9vTQMLaOZSkVALKnbEShA-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4a46c700dd0so999147137.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525546; x=1730130346;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TYeZsNInzGHmjRXw3GABtoyBiH6h2R4VP3kWoaBXn8g=;
 b=NZCDy7bi8yQ3fgWy5f4DMAIijNL0vgqB9h/X05ld2BvVnvcJX9WNDkvGoi5vxkFMPG
 kBBeMw1Kan++IVFnNuSfecno07+b/yYXT248ZcXkn1tpR5/8Q/GzfxdH9WnuivA+DD/N
 1Igtq9STSWouqCUAqw8KPsw8C2ncaZAYomzLLuNUmUa8CPdRVKuTTKETL1BVhIvJ7vWr
 cfu3NExFG+o/f5GPGzEnsdCICASSV3x3PldkbKMXszxi/So5SfizzvN11zED3WGjQQpw
 WH7aMlppJems2Q+XuKXNvuB7AvOIhKzZvFtnBw5p6BUjgpm4dqQ8cEIQc5ZvYrLc72rz
 lOsg==
X-Gm-Message-State: AOJu0YyOFIgZnXfYJm5bgC3aJZbdtFaDliZUqDn+TR7FZp0XYoie3CXN
 zVe9XPPu0HdJRS6vkqSZUlQDyocmWhMKGK5zUy8LeJEYqQIVtyeAEYY+VjD1iqb32mEgAsezF6e
 YeycIEyxiz+pyi1kxi5Sst7+1eRg49PfTpKTUo/xyEhg2ZCnDbavP
X-Received: by 2002:a05:6102:3f14:b0:4a4:9915:de61 with SMTP id
 ada2fe7eead31-4a5d6bee2eemr12119870137.28.1729525546215; 
 Mon, 21 Oct 2024 08:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVY70fkHNgCuB/nP1gvphv6DHPhpGji1Y3AN9SJqUxkxFmMW5meVymhfTQaDeLQg1JJSsHNA==
X-Received: by 2002:a05:6102:3f14:b0:4a4:9915:de61 with SMTP id
 ada2fe7eead31-4a5d6bee2eemr12119811137.28.1729525545730; 
 Mon, 21 Oct 2024 08:45:45 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3b304sm18847751cf.6.2024.10.21.08.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:45:45 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:45:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] util: don't set SO_REUSEADDR on client sockets
Message-ID: <ZxZ3Jo51ZjZFUiJ8@x1n>
References: <20241021145410.1420261-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241021145410.1420261-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 21, 2024 at 03:54:10PM +0100, Daniel P. Berrangé wrote:
> Setting the SO_REUSEADDR property on a socket allows binding to a port
> number that is in the TIMED_WAIT state. This is usually done on listener
> sockets, to enable a server to restart itself without having to wait for
> the completion of TIMED_WAIT on the port.
> 
> It is also possible, but highly unusual, to set it on client sockets. It
> is rare to explicitly bind() a client socket, since it is almost always
> fine to allow the kernel to auto-bind a client socket to a random free
> port. Most systems will have many 10's of 1000's of free ports that
> client sockets will be bound to.
> 
> eg on Linux
> 
>   $ sysctl -a | grep local_port
>   net.ipv4.ip_local_port_range = 32768	60999
> 
> eg on OpenBSD
> 
>   $ sysctl -a | grep net.inet.ip.port
>   net.inet.ip.portfirst=1024
>   net.inet.ip.portlast=49151
>   net.inet.ip.porthifirst=49152
>   net.inet.ip.porthilast=65535
> 
> A connected socket must have a unique set of value for
> 
>  (protocol, localip, localport, remoteip, remoteport)
> 
> otherwise it is liable to get EADDRINUSE.
> 
> A client connection should trivially avoid EADDRINUSE if letting the
> kernel auto-assign the 'localport' value, which QEMU always does.
> 
> When QEMU sets SO_REUSEADDR on a client socket on OpenBSD, however, it
> upsets this situation.
> 
> The OpenBSD kernel appears to happily pick a 'localport' that is in the
> TIMED_WAIT state, even if there are many other available local ports
> available for use that are not in the TIMED_WAIT state.
> 
> A test program that just loops opening client sockets will start seeing
> EADDRINUSE on OpenBSD when as few as 2000 ports are in TIMED_WAIT,
> despite 10's of 1000's ports still being unused. This contrasts with
> Linux which appears to avoid picking local ports in TIMED_WAIT state.
> 
> This problem on OpenBSD exhibits itself periodically with the migration
> test failing with a message like[1]:
> 
>   qemu-system-ppc64: Failed to connect to '127.0.0.1:24109': Address already in use
> 
> While I have not been able to reproduce the OpenBSD failure in my own
> testing, given the scope of what QEMU tests do, it is entirely possible
> that there could be a lot of ports in TIMED_WAIT state when the
> migration test runs.
> 
> Removing SO_REUSEADDR from the client sockets should not affect normal
> QEMU usage, and should improve reliability on OpenBSD.
> 
> This use of SO_REUSEADDR on client sockets is highly unusual, and
> appears to have been present since the very start of the QEMU socket
> helpers in 2008. The orignal commit has no comment about the use of
> SO_REUSEADDR on the client, so is most likely just an 16 year old
> copy+paste bug.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03427.html
>     https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg01572.html
> 
> Fixes: d247d25f18764402899b37c381bb696a79000b4e
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks for digging this.  It's good already to see some line removed on the
client side where it doesn't seem to clear why REUSE is needed at all..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


