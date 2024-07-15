Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE50C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTL7m-00087f-ID; Mon, 15 Jul 2024 08:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTL7g-00084s-LB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTL7e-0005Ad-Ih
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721047682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pfu6O8lg34RbDkDfXlGkHEP1e9e4uZMaHydNy/7oGns=;
 b=fsmN9YzkpX6yneJ1+aems7w0Yhqja5tSLqk/qkoDoGd3ivk3UBT542eMgcq2rN2UOxitvM
 iHieOzRabHLqolZO8ALk+ZyidmoaxkDSHKfiD0Fl3G5wn6EUS38WKzDpgXYX66JSIstnHN
 qcyBuVMXt/A4BMfHF4zPVS2dZTrmO/M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-E-zgKDX4MBuglY45-7PhHw-1; Mon,
 15 Jul 2024 08:47:59 -0400
X-MC-Unique: E-zgKDX4MBuglY45-7PhHw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3E41955D5B; Mon, 15 Jul 2024 12:47:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53A061955F40; Mon, 15 Jul 2024 12:47:54 +0000 (UTC)
Date: Mon, 15 Jul 2024 13:47:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] meson: Update meson-buildoptions.sh
Message-ID: <ZpUad0qRK2xBAnV5@redhat.com>
References: <20240705054903.2100562-1-zhao1.liu@intel.com>
 <Zoe625Z3JxlB4G5D@redhat.com> <ZpUdgyNb2lFga9PU@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpUdgyNb2lFga9PU@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CC qemu-trivial

On Mon, Jul 15, 2024 at 09:00:51PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> On Fri, Jul 05, 2024 at 10:20:27AM +0100, Daniel P. Berrangé wrote:
> > Date: Fri, 5 Jul 2024 10:20:27 +0100
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: Re: [PATCH] meson: Update meson-buildoptions.sh
> > 
> > On Fri, Jul 05, 2024 at 01:49:03PM +0800, Zhao Liu wrote:
> > > Update meson-buildoptions.sh to stay in sync with meson_options.txt.
> > > 
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > >  scripts/meson-buildoptions.sh | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> 
> Thanks!
> 
> BTW, could you please help merge this change? Because recently this
> script has been "polluting" my git staging workspace during
> development.
> 
> Regards,
> Zhao
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


