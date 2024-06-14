Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F3CC27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI7XL-0003MV-GO; Fri, 14 Jun 2024 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI7XF-0003JY-Qh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 10:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI7XD-0000Dt-Vc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 10:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718373847;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpjxrsPPxGzcCt+5741ZKrqYdx2rSbh2VGuoKNfKrDA=;
 b=JkIAhXS/IUg1aKVQGBW9mmtl+FEgjdAMexYQxDjC7g82y3auGig8YKaOceOiYeDvDKFNFY
 GA4BUbch+2QiGPIjC07OhUJrGidAG3amHhU2rXwyaKAzlYrCtCCMZl2/ShoQm9gawL8Hyc
 tZoPGfJsCMhXTsC+0lkbeOWTKlBFvQo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-MO0UB9feM46DI02pqhAurw-1; Fri,
 14 Jun 2024 10:04:03 -0400
X-MC-Unique: MO0UB9feM46DI02pqhAurw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D63F19560BF; Fri, 14 Jun 2024 14:04:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BD411956087; Fri, 14 Jun 2024 14:03:54 +0000 (UTC)
Date: Fri, 14 Jun 2024 15:03:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU devel <qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Message-ID: <ZmxNx81Hr9u53_Hs@redhat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
 <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
 <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 14, 2024 at 01:17:39PM +0800, maobibo wrote:
> 
> 
> On 2024/6/14 下午12:27, Jiaxun Yang wrote:
> > 
> > 
> > 在2024年6月14日六月 上午4:32，maobibo写道：
> > > It is interesting.
> > > 
> > > How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or
> > > ethernet magic packet or qemu monitor command in background?
> > 
> > Hi Bibo,
> > 
> > The best way to wake the guest is system_wakeup command in monitor.
> Ok, I see.
> 
> It is useful and it can be used to test S3/S4 in TCG mode at least.
> 
> Can we add feature capability, enabled in TCG mode, disabled in KVM mode by
> default? If vm deploys in cloud, users in general help it is power-on
> always.

Please avoid creating differing defaults between TCG and KVM where
practical.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


