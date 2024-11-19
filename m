Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE0D6C2A1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDW0u-0003E0-7Z; Tue, 19 Nov 2024 16:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDW0s-0003Dq-23
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDW0q-00077b-KL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732052634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVezol9pwCcqfuuYstYfOML9hc0oQOxR4eJ3RTFXvw4=;
 b=APPOVMS6QBo96iuxcCjBGlJMb/V4TW1xrtRoFfcCywYeeG6HsfFPnXblwWu1md0v4B/hK2
 6ckm92Q6LxYeOflwFFtZ9/t7UfZAOpmvHrZi8E/yPVS3zWRwTeGh/i3dGZxFETJRX709iH
 Iereu//jWg+hg3WYRRS0rF30kuFrg0I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-yCWL9nSUMzGTzCmBTxgLhg-1; Tue, 19 Nov 2024 16:43:53 -0500
X-MC-Unique: yCWL9nSUMzGTzCmBTxgLhg-1
X-Mimecast-MFC-AGG-ID: yCWL9nSUMzGTzCmBTxgLhg
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460ca856886so19879471cf.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 13:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732052632; x=1732657432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVezol9pwCcqfuuYstYfOML9hc0oQOxR4eJ3RTFXvw4=;
 b=tjp2g9F2ESoIoG0qNp8zfU3jTPqiJeyzplZL5BMN9aFV0VRE9rcFP6hHNcwKXHlpFT
 N02xbON0xCAXc61OyAaBCW3G4zlm4IRoPperEv/FfVdA6hWfTatRSbZR/5x2YsfKoIkz
 RRAVlilj7NS56OLV03S9tyrTpvu17QyXjYxCfHdAoxIlm1T6zF6bLaIz9QBH0bWZhTNZ
 cNTDWCNt2CaQKuV3XhyNIynsh4KS0bqdbT5bzCKjkiEokjIKFp5Fg7xxgsOqfP1NF8Nl
 oGNaYFPXNCBigFTvkZ1dWstPmx9Rf3Yu4eIqPWW/IeMCOki4mzZY3oCTZRSrnooNvYTl
 5ttw==
X-Gm-Message-State: AOJu0YxYKizDDNaT8Y8NFwQxaH9oPLnY1o4B/pWLLpsu/pjSpOnvvPFi
 xImWFSjZDidJZsfBcmVsEE3+6qmMFPOWg34fHd3WloyzDSb6EolT4XdIAUuXdWN6pMnfS3vK6gz
 6u5aB3+SNJkh8WYFSQj+7V7hPY0kt/nMQ/igCLHY7l/sxo3eozJqOOxIG590K
X-Received: by 2002:a05:622a:261a:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-4647965f936mr3158151cf.43.1732052632677; 
 Tue, 19 Nov 2024 13:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv5puoS0pogw0rg/ChymdU4T1wdqmbpHuPBEojJ5h8FKR2B27u7frMGHW7jHFzK5l4YR5Nhg==
X-Received: by 2002:a05:622a:261a:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-4647965f936mr3157941cf.43.1732052632374; 
 Tue, 19 Nov 2024 13:43:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4646a63f979sm992751cf.67.2024.11.19.13.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 13:43:51 -0800 (PST)
Date: Tue, 19 Nov 2024 16:43:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <Zz0GlJAYOzWrrOcC@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
 <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
 <Zzzv32xlLAH4O5Ig@x1n>
 <CABgObfaKrOvfhK5KfoxOOXOyZXeEz33VkvDeE=5wwtq3Ep=QdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfaKrOvfhK5KfoxOOXOyZXeEz33VkvDeE=5wwtq3Ep=QdQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 19, 2024 at 09:30:09PM +0100, Paolo Bonzini wrote:
> >
> > Do we have known places that we care a lot on object[_class]_dynamic_cast()
> > performance?
> 
> The easiest way to check is probably to print the type of every successful
> object_dynamic_cast and object_class_dynamic_cast. I suspect the result
> will be virtio-blk-device and/or scsi-hd, but maybe those already do an
> unsafe cast (pointer type cast) instead of object_dynamic_cast.

Yes, it sounds more reasonable to me to optimize specific call sites so far
rather than provides something generic..  Though it could still be a
generic API so that devices can opt-in.  Maybe still not as fast as an
unsafe cast, though.. I think I'll leave that to block experts when it may
needs some good measurements.

> 
> I can give it some measurement if there is, otherwise I'm
> > guessing whatever changes could fall into the noise.
> 
> 
> Yes, probably. At most you can identify if there any heavy places out of
> the 34000 calls, and see if they can use an unsafe cast.

I can still trivially do this.

I traced qemu using bpf and interestingly in my case close to half (over
10000+) of the calls are about ahci_irq_lower() from different higher level
stack (yeah I used IDE in my setup.. with a split irqchi..), where it has:

    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
                                                           TYPE_PCI_DEVICE);

So IIUC that can be open to a unsafe cast too, but considering IDE is ODD
FIXES stage, I'm not sure if I should send a patch at all.  However I
copied John regardless.

Thanks,

-- 
Peter Xu


