Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B572DC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTLj-0006BQ-D6; Thu, 16 Jul 2026 17:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wkTLh-000693-7F
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:10:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wkTLf-0002TX-Eb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:10:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ced3386430so35879275ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784236226; x=1784841026; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Ur2nukUfIP6QGhx5yPbuB/k/ylzfmbXYhSPR5nt4l8=;
 b=OxIA+fOL1sZqWrPKNyjUsSHSRbUNO1vKUAZeFLkkXouLPMHGEckuVcgjD02E7pX4JM
 vco6e7OJV55cTPfC/T72QY6+AzNcp8Ohe2itPZ+zU5dDAbZE3TfS36PP6zgNrr8EyuiF
 CizzBYVeKYAren+CUg5wQzJTG9o0GWjjB/CPWGF3WE6Jxf2Tj8sKD4P2EFr7p5BG0Ttp
 3iPg9zW40LkxOTiTTp1FRIbLPmXPZqSQNoUZqO8QDn5S718LulHqwDjvYyDx9w7DPZcI
 Tcze3xaUU960/1dvvvZuEr/nSqoI49fMTYqj/v3a/X/e4exKoCWucjtHLtEKbEnFGgMt
 K4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784236226; x=1784841026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Ur2nukUfIP6QGhx5yPbuB/k/ylzfmbXYhSPR5nt4l8=;
 b=DDThkb0n7I4s6cT8NF9HafASfX/tR4wOIczktRuyKoBneYovR+msKR7M8VSbl4X+cr
 PYrh+I4wSNfBleN3Rst74itUGXw5AiBU35eoe+o24ICV4WULGDqQsCpl4Ijur1kshF8m
 /TelinS+9OluVrC/Q7Bl0B67PFYTmQ+pJpHrA63pR+KjhqOYioNgz6x/EJ4S08EmZAwk
 FLcpbV43WApIY3rJaQ7FOFuVrXhGnYUsusT48fKHxSQzMyJ30/uthEToojU5UEFCtdur
 AQ7MZ1ZnTKLdorQdV6CDj4wSeWiGtKHBttVFmx8CsvE8lm1z9Qk10MiEwHuJrjIX7qzL
 1Gdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrav4XQopLi+jPxhZHb41HGBbfjFjPj//ocmdf5i00iKzYGFsz7dlTOh5APSMaJLG4kNLHmjJKnGYxI@nongnu.org
X-Gm-Message-State: AOJu0YyWYSuFSvr3oNO0C8qBxhnBxpMcjNvL60ZkWB+Fqm0rZ/4pGaT/
 zAKKKR2ehyzA22obmjtKt6N4mqObdJxLkLclJmin4oxKrwVQeJWxHzJdf4wDD2eZxOw=
X-Gm-Gg: AfdE7cltQgJ/vIATE1B2Xyq2K2AOFdvImK0miL8RDKaA9+Fz2cLBC8AKCLKR5kkHPm8
 PUxY9H7cd6+Of32ikQdMFWvRdjqDWnXUl7SkHjkrZVPVnmrleeGoQ19X/XHTZtaUfgG0wJ5CoQV
 jGarEg7Ov7J4D4YrXQqAM1HfEIL09UHlBb2OlcB5H4keJvfLMYX4JofgsjfFmRAgV+/JQGbA6jS
 QsdiW+bS4h7tZdcMAJrJcXbTfkly4ec67Pe9elrpbNEJHO0KLxqcpOlgkmc/XwY84B/qPBG/AZ8
 jqG98TkNgNX1KHY+G++bSlHZIMq8Hz7mcJ3hLt1tDFTLAgmIVviqsx1XlOw3kergP0U+9Jr6PnH
 kNgFN48SxUD8rF3R/jax4gaAU3oZBgx9Q5u/3Kv+0FNVxw6tW+UbxDDwZ/sDsHKD91hPerWO0B+
 dcC3OLog==
X-Received: by 2002:a17:902:e552:b0:2ca:2073:3119 with SMTP id
 d9443c01a7336-2cf2eb31d23mr11590055ad.32.1784236225769; 
 Thu, 16 Jul 2026 14:10:25 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf101434aesm25814365ad.28.2026.07.16.14.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 14:10:25 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:10:22 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
Message-ID: <allIviFWgoKgDob1@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
 <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 08:52:43PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a function to register a notifier that is invoked when ROMs get
> > loaded into guest memory.
> > 
> > It will be used by Arm confidential guest support, in order to register
> > all blobs loaded into memory with KVM, so that their content is moved
> > into Realm state and measured into the initial VM state.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/core/loader.c         | 15 +++++++++++++++
> >   include/hw/core/loader.h | 17 +++++++++++++++++
> >   2 files changed, 32 insertions(+)
> > 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 5cbfba0a86d2..b3d769bec5cb 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -74,6 +74,8 @@
> >   #endif
> 
> The (edk2) firmware for the realm guest can be specified by the legacy
> '-drive if=pflash' or '-bios'. The memory region corresponding to the
> firmware image specified by '-bios' is recorded by the newly added notifier
> and populated to TF-RMM properly.
> 
> I don't see how the memory region corresponding to (edk2) firmware image
> specified by '-drive if=pflash' is recorded and populated to TF-RMM
> accordingly in this series. So I guess '-drive if=pflash' isn't supported
> yet?

Please give '-drive if=pflash' a try and let me know how you fare.  Edk2 is not
part of the bootstack I'm currently testing with but I know of configurations
where it does work.

I'll add it to my list of things to do if it doesn't work, though I may not
address it in this patchset.  We'll see how busy things get.

> 
> Note that I didn't give '-drive if=pflash' a try yet.
> 
> >   static int roms_loaded;
> > +static NotifierList rom_loader_notifier =
> > +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
> >   /* return the size or -1 if error */
> >   int64_t get_image_size(const char *filename, Error **errp)
> > @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
> >       return mr;
> >   }
> > +void rom_add_load_notifier(Notifier *notifier)
> > +{
> > +    notifier_list_add(&rom_loader_notifier, notifier);
> > +}
> > +
> >   /* This function is specific for elf program because we don't need to allocate
> >    * all the rom. We just allocate the first part and the rest is just zeros. This
> >    * is why romsize and datasize are different. Also, this function takes its own
> > @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
> >   static void rom_reset(void *unused)
> >   {
> >       Rom *rom;
> > +    RomLoaderNotifyData notify;
> >       QTAILQ_FOREACH(rom, &roms, next) {
> >           if (rom->fw_file) {
> > @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
> >           address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
> >           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> > +
> > +        notify = (RomLoaderNotifyData) {
> > +            .addr = rom->addr,
> > +            .len = rom->datasize,
> > +            .as = rom->as,
> > +        };
> > +        notifier_list_notify(&rom_loader_notifier, &notify);
> >       }
> >   }
> > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > index d9431e8a8d12..94cf6ad2e26b 100644
> > --- a/include/hw/core/loader.h
> > +++ b/include/hw/core/loader.h
> > @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> >   ssize_t rom_add_vga(const char *file);
> >   ssize_t rom_add_option(const char *file, int32_t bootindex);
> > +typedef struct RomLoaderNotifyData {
> > +    /* Address of the blob in guest memory */
> > +    hwaddr addr;
> > +    /* Length of the blob */
> > +    size_t len;
> > +    /* Address space of the blob */
> > +    AddressSpace *as;
> > +} RomLoaderNotifyData;
> > +
> > +/**
> > + * rom_add_load_notifier - Add a notifier for loaded images
> > + *
> > + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
> > + * each blob loaded into guest memory, after the blob is loaded.
> > + */
> > +void rom_add_load_notifier(Notifier *notifier);
> > +
> >   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
> >    * overflow on real hardware too. */
> >   #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
> 
> Thanks,
> Gavin
> 

