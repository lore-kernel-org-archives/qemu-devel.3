Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F9E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 19:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRJx-0006u6-Oi; Thu, 02 Jan 2025 14:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRJw-0006tu-Fs
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRJu-0005Z7-No
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735847844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9w4m4k+PPUARZOXcTHJr54QHMPsWHH+tWn2MXFybP0=;
 b=U1EGHzQMgDYEBSeBnMl3G4SCiByeccUYnLxRBvsiQmelUh9MBqEsNuzHUAJxpO8zJuqUcu
 1YK88IuZcquXdh8Wd8YZsK3cl5jV82PhRSygYLidyHNR3NcAedSfLb6x2RQC+P8gbrRsd1
 c47srhYK3d6y75VE5huVA6WqWVj1AkI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-T9VQuBPeNdKMU7T7kBu80g-1; Thu, 02 Jan 2025 14:57:22 -0500
X-MC-Unique: T9VQuBPeNdKMU7T7kBu80g-1
X-Mimecast-MFC-AGG-ID: T9VQuBPeNdKMU7T7kBu80g
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6e9fb0436so3746792385a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 11:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735847842; x=1736452642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9w4m4k+PPUARZOXcTHJr54QHMPsWHH+tWn2MXFybP0=;
 b=uqutwtYqVlmGAnoS7e6IEFoyeZz7B2L9MDJACttCcQo0mXwAeo0OWjXAxQjd0R0uxK
 VmdNFU9cPs/xTCw+wbr4GtrO9ljEuqtGoQ39FXT54k+5H8juipkf4GVC+hnQ9tM4C1BL
 KVcoIqZSPJg4idK/tg6TJX9whiu4O4gNqQhgdEO/JgpvIA5bw0i+9/UWFFJy3XP45DPX
 IaWHDJeHVCMiKIFf3QB1COVreOVhzasq9ZEdq83WBGSugvH3SwVSyD5TEXpo1bPJdqVN
 H9yqY7CZR4x39z2h2XRn9H2NJ0oYIGM1WszPOm3KYMXUbsuO2WgzJtKe7XYqh9vVoB8n
 xH6Q==
X-Gm-Message-State: AOJu0Yx6yJ51rVggxHkkVzqMiOja1xRamDVvFgjqP115Kye5I46KC0b4
 GjPz+wvtG4YL8jAUrlWgHax2wSPQrR5QPCdWIm842ZlEJHfM8y0N7tvp5s5x1q+PN2tVPNDlKmQ
 XJuagS2kZICbxlxt2utJGbl718kDA2ZoNSlgDxxMamayQM2KmJU/J
X-Gm-Gg: ASbGnctBay4b8DLoonPRW/16EK/N6U2RBxKtbSrFEW0/XZIW8MQKpjRB6/dqcI8Ljhv
 wbHCPmkhPPbqRTu2D5oMRcuPlmRHppX0f0g56AXK2O+ofM/Sl9enCTaMDcu5VXEGp8kXK/gUmYO
 8fySo3Rcpcos27sKKEEMj5jVUM+LtAzevSPuLboaQx46QhHO+21ufHGutr5Jgs4lZrogwiTzq+h
 4+XnhkLWNkO3k+DEoYgS95vv0uA0Rq5fpwwzOIf9pAXUFT46FofdXKwHTSybbqdZA5GMTyPbmuh
 p+G6CidBf9cKGkf3Hw==
X-Received: by 2002:a05:620a:4897:b0:7b6:f995:6e08 with SMTP id
 af79cd13be357-7b9ba7aa40dmr8356420285a.31.1735847842280; 
 Thu, 02 Jan 2025 11:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkZr9qunRcUNlTrkm9LqdfkwvFL2aiN9oLdX6HHEEe/DTtm5ZHq5w2pS+HnsUqTKi/gfCN5A==
X-Received: by 2002:a05:620a:4897:b0:7b6:f995:6e08 with SMTP id
 af79cd13be357-7b9ba7aa40dmr8356417685a.31.1735847842008; 
 Thu, 02 Jan 2025 11:57:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4cc3ffsm1207346085a.109.2025.01.02.11.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 11:57:21 -0800 (PST)
Date: Thu, 2 Jan 2025 14:57:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
Message-ID: <Z3bvnlQ955dWzc-n@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <Z2sKXAgsUW3A8ajg@x1n>
 <72eaea07-ccfc-4134-84c5-1bc044f7ddae@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72eaea07-ccfc-4134-84c5-1bc044f7ddae@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 02, 2025 at 02:21:13PM -0500, Steven Sistare wrote:
> On 12/24/2024 2:24 PM, Peter Xu wrote:
> > On Tue, Dec 24, 2024 at 08:17:00AM -0800, Steve Sistare wrote:
> > > Add the cpr-transfer migration mode, which allows the user to transfer
> > > a guest to a new QEMU instance on the same host with minimal guest pause
> > > time, by preserving guest RAM in place, albeit with new virtual addresses
> > > in new QEMU, and by preserving device file descriptors.  Pages that were
> > > locked in memory for DMA in old QEMU remain locked in new QEMU, because the
> > > descriptor of the device that locked them remains open.
> > > 
> > > cpr-transfer preserves memory and devices descriptors by sending them to
> > > new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
> > > be sent over the normal migration channel, because devices and backends
> > > are created prior to reading the channel, so this mode sends CPR state
> > > over a second "cpr" migration channel.  New QEMU reads the cpr channel
> > > prior to creating devices or backends.  The user specifies the cpr channel
> > > in the channel arguments on the outgoing side, and in a second -incoming
> > > command-line parameter on the incoming side.
> > > 
> > > The user must start old QEMU with the the '-machine aux-ram-share=on' option,
> > > which allows anonymous memory to be transferred in place to the new process
> > > by transferring a memory descriptor for each ram block.  Memory-backend
> > > objects must have the share=on attribute, but memory-backend-epc is not
> > > supported.
> > > 
> > > The user starts new QEMU on the same host as old QEMU, with command-line
> > > arguments to create the same machine, plus the -incoming option for the
> > > main migration channel, like normal live migration.  In addition, the user
> > > adds a second -incoming option with channel type "cpr".  The CPR channel
> > > address must be a type, such as unix socket, that supports SCM_RIGHTS.
> > > 
> > > To initiate CPR, the user issues a migrate command to old QEMU, adding
> > > a second migration channel of type "cpr" in the channels argument.
> > > Old QEMU stops the VM, saves state to the migration channels, and enters
> > > the postmigrate state.  New QEMU mmap's memory descriptors, and execution
> > > resumes.
> > > 
> > > The implementation splits qmp_migrate into start and finish functions.
> > > Start sends CPR state to new QEMU, which responds by closing the CPR
> > > channel.  Old QEMU detects the HUP then calls finish, which connects the
> > > main migration channel.
> > > 
> > > In summary, the usage is:
> > > 
> > >    qemu-system-$arch -machine aux-ram-share=on ...
> > > 
> > >    start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
> > > 
> > >    Issue commands to old QEMU:
> > >      migrate_set_parameter mode cpr-transfer
> > > 
> > >      {"execute": "migrate", ...
> > >          {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Feel free to take:
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > I still have a few trivial comments.
> > 
> > [...]
> > 
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index 87bcfdb..584b0b9 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -45,7 +45,7 @@ static const VMStateDescription vmstate_cpr_fd = {
> > >           VMSTATE_UINT32(namelen, CprFd),
> > >           VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
> > >           VMSTATE_INT32(id, CprFd),
> > 
> > Could you remind me again on when id!=0 will start to be used?
> 
> Each of vfio, iommufd, chardev, and tap will use id != 0.

I don't remember the details of the planned future series, but just to
mention that using integer ID can be error prone on device hot plug/unplug.

QEMU has a known bug even now on some device (e.g. slirp network backends)
that if the src QEMU originally has two devices (e.g. id=1,2), unplug
device id=1 (leaving id=2), then migrate, it could fail seeing dest only
has id=1 (dest QEMU starts with only one device), seeing a mismatched ID.

I recall PCIe frontend devices are not prone to such issue, that should
depend on whoever has ->get_id() (qdev_get_dev_path?) properly implemented
to generate a global unique ID that is not affected by order of device
realized / created.

It could boil down to how the IDs are allocated, anything that can be
allocated on the fly may not work well if there's no solid topology
information to fetch.

I wonder if CPR can be prone to this too when using IDs, just FYI.  It
might be a good idea if ID integers can be avoided somehow.  But you'll
definitely have the best picture of the whole thing, so it may or may not
apply.

Thanks,

-- 
Peter Xu


