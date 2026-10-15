Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAC1CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHS85-0003Ox-HO; Thu, 15 Oct 2026 16:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHS7D-0003FS-Oz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHS7B-0005qj-2G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-88834d30002so2961646b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792096307; x=1792701107; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NAEDuPRm7VuyIEB7+bHe35wWBeKMJ9cvJsYHTvEIilg=;
 b=vgyTAByjWM8bFeOQ6OWUYzlWUOX3qp8pamxM5JlbdZkO8TFHYDx/B19v0VxckuoMI2
 ai3j1JqakCumo+FOm+PrpllmHvQ+fFd48B8MRvesmTxpCVH22bpvyNQPz0OpOCDsILgc
 ZC0TyWmecE9c5NRH/Aa4xr13WKq0Ze/s8GKbVojE6ifdKhD9f8MoXLQnDe6eLmKHkP5o
 nsBnXUiV2lsedf5HEaWK4Nh834DH0JNT1EtU3FEJcGQ0+xCYzXN+FUb+aq2xxhDU40sJ
 J1RvkYEkoyZvJwlkdZITE7CXkzizYlsWGKgj0hlUDyFRfo0Q+QWFzv/ByHMgd2wBGJW0
 5V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792096307; x=1792701107;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NAEDuPRm7VuyIEB7+bHe35wWBeKMJ9cvJsYHTvEIilg=;
 b=ip5+uweKcQri0CA96uYg3UO3sOzuttzbSA2okmmQ++LuBdFWzf6P7wCVdW3QqWJxSd
 iZzjDGdZhjUY6g05MoTYMqBiFNDiXHBRBS83vA50e+huiBWXNeGb99UDzsXgJKWNwS95
 9bdOQ2RizwaMUPmPYMWTP+dbPhSm1T2bnJ3TM8AR1sXR9IeTBnNIU/Akd9VCLKRCMKgV
 SrsFGrAFzc0+/T2wGfceiA/JLcraDmviydRw44sKeyu+YnHBF8kI3nZu742HA2r+2gNs
 qZrs3E4IA/+U8YTGkgOjcCHh5ANRxaqQsR9N6LrlPQPfJVBR+qH5rf9KFv7YiOrW+Bqm
 2qdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1CecJFzYz3OP6NfZcNECtWpQ4A+KWGjc3N6wjajTz211ql5y4NWK74JLbSbg7LtpHFcLt0sTiT4Dh@nongnu.org
X-Gm-Message-State: AFq9FYKAwhSWE1tftoQ025xqXH/xel5hLM6vGz9oGZx/W0if/iyg59Q3
 vaiuvSQMWewFZe5CVOmcBgg0PITSFTQ0WHz7bNsEzg/qxczTaA2/oegIxcA3AQFkr0c=
X-Gm-Gg: AYBFou2bOxLsFHkqfDoMysRbN1gao+abYbRnDlgZo/tyNu7ANyHvEy8vDbGKClnR5OY
 WjltYaNwNbKhQF9ifl2uqwd4MI0CLxJbt264pwJDm//tFcRwiO6fjdgkc0lKLHB8skxkObhHp7B
 RgqZCyH2ObEb5RhdWm3JDDE2hj3vryR5QT+jPkXzNX0lVy63MalwYWDYurqwE3VrkV1xab3B/tj
 Ci2I8uG32uNdDZjt/GiiyHZAk8no1hVcWsrGM0O5f6yTI47zbU3P4HnbuZFU+KZrGePC4aeHCZM
 CU+GioRiX47IZDAdp+4ectPAAPPYQveFDF0KN/D9ny5qDKp9Mf8OcxQoDh8UZIm6/w+JHiF3txj
 NpfqXcBjUJe4tK71tSJlOmyfApnOYWWHBHpwfmfcRkhdFb3GGwXEtCxxQT9Pwa/anx6+TmU7MpS
 Ao/WhGdJju2cxGs1Na3DARmN3ctmxbUEgXZz2TfGGtBo84yg4TnWAhJAVhDjkcDYp4U1kYAoNUB
 A==
X-Received: by 2002:a05:6a21:4598:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3e16bf4c2b2mr16280104637.78.1792096307215; 
 Thu, 15 Oct 2026 13:31:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:48ff:8de9:17ca:1542])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c8bc14sm123063b3a.17.2026.10.15.13.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:31:46 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:31:42 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
Message-ID: <atE4LncFX15FdVvO@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-10-mathieu.poirier@linaro.org>
 <ad73d89f-6615-49c1-a35e-3f01e7305744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad73d89f-6615-49c1-a35e-3f01e7305744@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x431.google.com
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

On Fri, Oct 02, 2026 at 11:15:08AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
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
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/core/loader.c         | 15 +++++++++++++++
> >   include/hw/core/loader.h | 17 +++++++++++++++++
> >   2 files changed, 32 insertions(+)
> > 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 5cbfba0a86d2..388f10e828db 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -74,6 +74,8 @@
> >   #endif
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
> > +            .data = rom->data,
> > +        };
> > +        notifier_list_notify(&rom_loader_notifier, &notify);
> >       }
> >   }
> > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > index d9431e8a8d12..fdfddfa7443e 100644
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
> > +    /* Blog data */
>           ^^^^
> I guess it would be 'Blob'.
> 
> > +    uint8_t *data;
> > +} RomLoaderNotifyData;
> > +
> 
> There are enough space at the tail of field declaration lines, where the
> comments can be put:
> 
> typedef struct RomLoaderNotifyData {
>     hwaddr  addr;   /* Address of the blob in guest memory */
>     size_t  len;    /* Length of the blob */
>     uint8_t *data;  /* Blob data */
> } RomLoaderNotifyData;
>

Fixed
 
> 
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

