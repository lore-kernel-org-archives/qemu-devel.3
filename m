Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DF1C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjX7-0001MJ-5z; Mon, 24 Jun 2024 09:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLjX5-0001M3-5e
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLjX3-0004xn-6G
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719234891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psoXTWsyRrOWGiZ3rF1af656XfNZf/PEqwEZrKB+trs=;
 b=TSnLSfTiry6rWcy+aBrEoVwWdwH9NM+mU6SWMsP5iM1rVpi5aQ0dyIKW2n10uXLr3wfL3e
 LwhAaiSDq3/Ilv6zvwA7WybN92VBrJNIDeLugHetm1JO/Xb+U3/T/oSPmJTeQBYXmfrTnk
 jpjmCyobnip3jkxtI46j/j4yJtvw7P0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-H-r7trx6N1u0ScVAJSJEkQ-1; Mon, 24 Jun 2024 09:14:49 -0400
X-MC-Unique: H-r7trx6N1u0ScVAJSJEkQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec55065e52so13340251fa.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234888; x=1719839688;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=psoXTWsyRrOWGiZ3rF1af656XfNZf/PEqwEZrKB+trs=;
 b=HPtNHMo49/VPMqBMi5JxCsFvrDysAb63bGeHPU/6fDBVs8dIFKEIHai5ouhfltI9l4
 zi5M/I+jhdZJbUnXCcqZOYGaTLMEZupHSr7pQH3T49CtaU3SGktLp27TeehykPjQnQbo
 qCD2LPRBbj6tWaBgXCsO6jPM4CKPLIq1h5blU9Z2a+m/R75lL2YgGw8w/8581AOVTazJ
 CC9BKaP1/h4eLRlY7aqFOJu6OHC93RZhM/qzhZS7LDHCWpBXT04QwJbL0f7i+umRFVCw
 QrrK+OkdMLDrGgY8WltZ6U5CbgbrntqhMQvKhiVGGx7Ua23FlxM6Ygxj1UljR8+JOs0G
 oLBw==
X-Gm-Message-State: AOJu0Yxe84jJqT/eKrZXQE4ozuQNakxqGf/N4nIhsmLlZrhbmxGzZi58
 JhuIgZ1N50CH8HqwGFAgOIJwZsolyhcd5la6wvj6kcnQDUHVRYMTf2qoGo3a70mrjL6pOatwBna
 Y4BRfIQ0Z46FX3Y4lDoOBeAeLh4YW2QcCmcb60RfY31NADtzHLUZY
X-Received: by 2002:a19:9115:0:b0:52c:df63:bebd with SMTP id
 2adb3069b0e04-52ce0673528mr3081102e87.49.1719234887613; 
 Mon, 24 Jun 2024 06:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK6SFsYetZGUqeLgQLZvwhl1ZS0DQXPNrYO89UhypzC2WfyA0fXYNZTx19ynIFE/km2tg/Xg==
X-Received: by 2002:a19:9115:0:b0:52c:df63:bebd with SMTP id
 2adb3069b0e04-52ce0673528mr3081072e87.49.1719234886822; 
 Mon, 24 Jun 2024 06:14:46 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910fd4sm133401405e9.30.2024.06.24.06.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:14:46 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:14:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386: revert defaults to 'legacy-vm-type=true' for
 SEV(-ES) guests
Message-ID: <20240624090345-mutt-send-email-mst@kernel.org>
References: <20240614103924.1420121-1-berrange@redhat.com>
 <20240624080458-mutt-send-email-mst@kernel.org>
 <Znlo4GMgJ91nKyft@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Znlo4GMgJ91nKyft@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 24, 2024 at 01:38:56PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jun 24, 2024 at 08:27:01AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jun 14, 2024 at 11:39:24AM +0100, Daniel P. Berrangé wrote:
> > > The KVM_SEV_INIT2 ioctl was only introduced in Linux 6.10, which will
> > > only have been released for a bit over a month when QEMU 9.1 is
> > > released.
> > > 
> > > The SEV(-ES) support in QEMU has been present since 2.12 dating back
> > > to 2018. With this in mind, the overwhealming majority of users of
> > > SEV(-ES) are unlikely to be running Linux >= 6.10, any time in the
> > > forseeable future.
> > > 
> > > IOW, defaulting new QEMU to 'legacy-vm-type=false' means latest QEMU
> > > machine types will be broken out of the box for most SEV(-ES) users.
> > > Even if the kernel is new enough, it also affects the guest measurement,
> > > which means that their existing tools for validating measurements will
> > > also be broken by the new default.
> > > 
> > > This is not a sensible default choice at this point in time. Revert to
> > > the historical behaviour which is compatible with what most users are
> > > currently running.
> > > 
> > > This can be re-evaluated a few years down the line, though it is more
> > > likely that all attention will be on SEV-SNP by this time. Distro
> > > vendors may still choose to change this default downstream to align
> > > with their new major releases where they can guarantee the kernel
> > > will always provide the required functionality.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > This makes sense superficially, so
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > and I'll let kvm maintainers merge this.
> > 
> > However I wonder, wouldn't it be better to refactor this:
> > 
> >     if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
> >         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
> >         
> >         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
> >     } else {
> >         struct kvm_sev_init args = { 0 };
> >                 
> >         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
> >     }   
> > 
> > to something like:
> > 
> > if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) != KVM_X86_DEFAULT_VM) {
> >         struct kvm_sev_init args = { 0 };
> >                 
> >         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
> > 	if (ret && errno == ENOTTY) {
> > 		cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
> > 
> > 		ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
> > 	}
> > }
> > 
> > 
> > Yes I realize this means measurement will then depend on the host
> > but it seems nicer than failing guest start, no?
> 
> IMHO having an invariant measurement for a given guest configuration
> is a critical guarantee. We should not be allowing guest attestation
> to break as a side-effect of upgrading a software component, while
> keeping the guest config unchanged.

Well attenstation can change for a variety of reasons involving software
upgrades: host or guest. It is up to user to either trust both old and
new attestion, or pick one. Seems better than forcing policy host side.

> IOW, I'd view measurement as being "guest ABI", and versioned machine
> types are there to provide invariant guest ABI.

In practice we can't always do this exactly: e.g. vhost has
a rich feature mask and what we do is clear features not
supported by a specific host kernel.

Similarly for vhost-user where the ABI depends on an
external component.

So things can change if you move across host kernels.




> Personally, if we want simplicitly then just not using KVM_SEV_INIT2
> at all would be the easiest option. SEV/SEV-ES are legacy technology
> at this point, so we could be justified in leaving it unchanged and
> only focusing on SEV-SNP. Unless someone can say what the critical
> *must have* benefit of using KVM_SEV_INIT2 is ?


No objection.

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


