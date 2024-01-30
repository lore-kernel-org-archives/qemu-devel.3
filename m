Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCD4C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrgF-00069m-RU; Tue, 30 Jan 2024 12:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUrgD-00068z-Uh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUrgC-00046q-9D
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:13:49 -0500
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-2DveGI9MMJariQGuyxoQog-1; Tue, 30 Jan 2024 12:13:44 -0500
X-MC-Unique: 2DveGI9MMJariQGuyxoQog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 888FD862FE1;
 Tue, 30 Jan 2024 17:13:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3943E492BE2;
 Tue, 30 Jan 2024 17:13:42 +0000 (UTC)
Date: Tue, 30 Jan 2024 17:13:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
Message-ID: <ZbkuQyfs3qDcF1H_@redhat.com>
References: <20240130164428.35955-1-anisinha@redhat.com>
 <ZbkoOAPo7gmFZw4g@redhat.com>
 <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 30, 2024 at 10:39:51PM +0530, Ani Sinha wrote:
> 
> 
> > On 30-Jan-2024, at 22:17, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Tue, Jan 30, 2024 at 10:14:28PM +0530, Ani Sinha wrote:
> >> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> >> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> >> enabled in the kernel. QEMU has been tested to correctly boot a linux guest
> >> with 1728 vcpus both with edk2 and seabios firmwares. So bump up the max_cpus
> >> value for q35 machines versions 9 and newer to 1728. Q35 machines versions
> >> 8.2 and older continue to support 1024 maximum vcpus as before for
> >> compatibility.
> > 
> > Where does the 1728 number come from ?
> > 
> > Did something break at 1729, or did the test machine simply not
> > have sufficient resources to do practical larger tests ?
> 
> Actual limit currently is 1856 for EDK2. The HPE folks tested QEMU with edk2 and QEMU fails to boot beyond that limit.
> There are RH internal bugs tracking this and Gerd is working on it from RH side [1].
> 
> We would ultimately like to go to 8192 vcpus for SAP HANA but 1728 vcpus is our immediate target for now. If you want, I can resend the patch with 1856 since that is currently the tested limit.

Yes, could you resend with 1856, and include a description of
the blocking problem in the commit message for the historical
record, as this is the kind of thing that people will have
forgotten when re-visiting the patch later and wondering why
this limit was chosen.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


