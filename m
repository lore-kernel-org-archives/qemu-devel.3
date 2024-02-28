Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD504C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIL5-0003m4-DC; Wed, 28 Feb 2024 06:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfIL1-0003la-6t
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfIKw-0001fO-3A
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MX7jZiabH9O68zX/KhxV/3jd6WaQK81ARwU6q/P/Dxk=;
 b=JK4q2TejDopWArZGIrEvOmDxMcvWjhdL+jAj/yIxp/qKdgb0bUTsqipXGNn2sCeAjv7eht
 klgIpiiedrtCptjNSlHBdE6htp2w8WuoZuEPiz43Ut3V1G4n9W1FiwmwJJfCbEVYTob5ns
 W3e9gsaRr06s23Mz1crB7jLlAdcrKRI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-8BNHeZBzNBam6iuDLnUIpw-1; Wed,
 28 Feb 2024 06:42:49 -0500
X-MC-Unique: 8BNHeZBzNBam6iuDLnUIpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 875821C05146;
 Wed, 28 Feb 2024 11:42:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC41B111D640;
 Wed, 28 Feb 2024 11:42:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 891381801480; Wed, 28 Feb 2024 12:42:46 +0100 (CET)
Date: Wed, 28 Feb 2024 12:42:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <y2jzxr5fy5p7s5ky6nu5c4gk5reeofc2xo5lnnpt345iq2brtp@5qrthy4nlbi5>
References: <20240221140227.3886-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140227.3886-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 21, 2024 at 07:32:27PM +0530, Ani Sinha wrote:
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> enabled in the kernel. At present, QEMU has been tested to correctly boot a
> linux guest with 4096 vcpus with edk2 pending various upstream EDK2 fixes
> which will probably be in the 2024-05 release to be released in the coming

Merged meanwhile, so 2024-05 release is a sure thing and latest edk2
master branch is good too.

You might refine the commit message saying so.
With or without that:
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


