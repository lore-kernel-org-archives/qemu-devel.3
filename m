Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BC7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTh4-0003Vm-O9; Wed, 27 Mar 2024 09:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpTgz-0003VF-2w
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpTgv-00032w-Ut
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711547504;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LltFgnV96yA+5oaQPxzKWau7+HQi3IGCMTVeFnOaKXE=;
 b=Lr3uPlbWuu04c2sE4vJBsjLF9IAoFyStpz46VmssSrbEHt15g7KIxv0Dne5ZTLVW4Woxz9
 CiTeFxcswk5Xnxl/uWlzSpmcTmtSbVoK6Gbtg5iifWSvk7vBZEfDFyRPJZgtgj4Z0fCjVB
 9/l66N49CS6x9AzqIM+48tHtinsMCZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-m4CycnTONQGpQGOzbcOnUA-1; Wed,
 27 Mar 2024 09:51:39 -0400
X-MC-Unique: m4CycnTONQGpQGOzbcOnUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B74C21C382BD;
 Wed, 27 Mar 2024 13:51:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEBB1400D5C6;
 Wed, 27 Mar 2024 13:51:34 +0000 (UTC)
Date: Wed, 27 Mar 2024 13:51:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <ZgQkS4RPmSt5Xa08@redhat.com>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 26, 2024 at 02:29:58PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Igor,
> 
> On 26/3/24 14:08, Thomas Huth wrote:
> > 
> > s/iaspc/isapc/ in the subject
> > 
> > On 26/03/2024 13.51, Igor Mammedov wrote:
> > > ISAPC machine was introduced 25 years ago and it's a lot of time since
> > > such machine was around with real ISA only PC hardware practically
> > > defunct.
> > > Also it's slowly bit-rots (for example: I was able to boot RHEL6 on
> > > RHEL9 host
> > > in only TCG mode, while in KVM mode it hung in the middle of boot)
> 
> I'm quite opposed to this patch. QEMU models various very-old /
> defunct hardware. I'm pretty sure Bernhard and myself are OK to
> keep maintaining it, besides we are working in separating it from
> the i440fx+piix machine. Also, this machine is particularly
> interesting for my single-binary experiments.
> 
> Where I agree is we should stop reporting "KVM on ISA/PC machine"
> as supported.

isapc could arguably be restricted to just 32-bit CPU models, because
we should not need it to support any feature that didn't exist prior
to circa 1995. eg refuse to start with isapc, if 'lm' is present in
the CPU model for example.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


