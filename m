Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5DDCEE343
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 19:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syc1Z-0005tn-UC; Wed, 09 Oct 2024 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syc1X-0005tX-Qd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syc1V-00053e-TO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728500820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APoMXTqsdw7YddleKAsLKZULEhpsqblufs4c6MH4CTQ=;
 b=W5eoDGRVf4onTSJPbnkm18DdWjwBdt/lI7TRZV2GuorRTn4zm8ktOVv7ZwhomesR/+Ho2Q
 VsUanNALzFW/tZLAs34cSebOrdekfXRZZQ98QFbVWrp1a5jt/ZSHLuPL0grY/gRliy36+e
 fc1w5JH5LM5JQ6t7GegctCwNiiYx2cI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-RvLFwDI_MqeEYeanj7wxIg-1; Wed, 09 Oct 2024 15:06:59 -0400
X-MC-Unique: RvLFwDI_MqeEYeanj7wxIg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-20b096ef923so623235ad.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 12:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728500818; x=1729105618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APoMXTqsdw7YddleKAsLKZULEhpsqblufs4c6MH4CTQ=;
 b=gTvxwmhX5QVsMvIwKbmoKCKkSVePhIHym0Y39j0WCoOFbVYIH06pkJMS6JgFdM8uvx
 rowK7+mD/YaO31UxZxZqeJTekazZeIqkHI4eqx6UcnP0eu4AA+IovydwXT19QCq+BwhP
 WgWkNKuu9o8CbR/DRsGDlraV9prRPoDKmIaXM327UF5t94qtSqsg4C9ft6q9ACPiOch6
 gvaTZA8rFVhq6IA+d6nrX70MUKfRk++joQRsR67BeNlfERTemlbs8hzqqHGjqNIzuHxi
 3EGPmnqAmAdTebDkCCzuRKZxkvcsOe4wvEyzMKodFL4K48yZE/8G9uADFHeGfLRCsfI5
 rJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvBQAzL6vSthhuuXFuZb8glrRnUNOuWuBg3ASFmrIqzMOt7N9w2NGXmJLBhYCAnGZPObsl6ycl9EUX@nongnu.org
X-Gm-Message-State: AOJu0YwQE04Md4EeiDIMn/tsgk+yC1AoqOMkcjZkL4++yV9XHsiZS/9F
 AqW0BCH8fOvPgEkyiU7Q7VzeUYKbkFX87P8bcME2Al+s3xhMjkufJT3Wr+ovcYgzLqsxdkXXvy0
 ie8UUgRYkeZXi55Q25x2jWDovfLfcXN+S8QyVcNeOOn+jXX+b2vSu
X-Received: by 2002:a17:902:d491:b0:20b:983c:f095 with SMTP id
 d9443c01a7336-20c6378fc02mr52308565ad.51.1728500817938; 
 Wed, 09 Oct 2024 12:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZKxtzeuc/mjRJSOfpkEaB44oM+/N4AOsvwMxVade0XcyA4ste+97ie08kKKh3Gm1T3cYE3A==
X-Received: by 2002:a17:902:d491:b0:20b:983c:f095 with SMTP id
 d9443c01a7336-20c6378fc02mr52308095ad.51.1728500817459; 
 Wed, 09 Oct 2024 12:06:57 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138b047fsm74322475ad.44.2024.10.09.12.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 12:06:57 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:06:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwbUTXCxxl4heZYV@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
> On 10/8/2024 3:48 PM, Peter Xu wrote:
> > On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
> > > As of half an hour ago =) We could put a feature branch up and work
> > > together, if you have more concrete thoughts on how this would look like
> > > let me know.
> > 
> > [I'll hijack this thread with one more email, as this is not cpr-relevant]
> > 
> > I think I listed all the things I can think of in the wiki, so please go
> > ahead.
> > 
> > One trivial suggestion is we can start from the very simple, which is the
> > handshake itself, with a self-bootstrap protocol, probably feature-bit
> > based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
> > how to handshake".
> > 
> > Comparing to the rest requirement, IMHO we can make the channel
> > establishment the 1st feature, then it's already good for merging, having
> > feature bit 1 saying "this qemu understands named channel establishment".
> > 
> > Then we add new feature bits on top of the handshake feature, by adding
> > more feature bits.  Both QEMUs should first handshake on the feature bits
> > they support and enable only the subset that all support.
> > 
> > Or instead of bit, feature strings, etc. would all work which you
> > prefer. Just to say we don't need to impl all the ideas there, as some of
> > them might take more time (e.g. device tree check), and that list is
> > probably not complete anyway.
> 
> While writing a qtest for cpr-transfer, I discovered a problem that could be
> solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
> 
> There is currently no way to set migration caps on dest qemu before starting
> cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
> devices or monitors. It is unblocked after the user sends the migrate command
> to source qemu, but then the migration starts and it is too late to set migration
> capabilities or parameters on the dest.
> 
> Are you OK with that restriction (for now, until a handshake is implemented)?
> If not, I have a problem.
> 
> I can hack the qtest to make it work with the restriction.

Hmm, the test case is one thing, but if it's a problem, then.. how in real
life one could set migration capabilities on dest qemu for cpr-transfer?

Now a similar question, and also what I overlooked previously, is how
cpr-transfer should support "-incoming defer".  We need that because that's
what Libvirt uses.. with an upcoming migrate_incoming QMP command.

-- 
Peter Xu


