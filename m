Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD89C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 21:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSNsb-0002g9-El; Tue, 23 Jan 2024 16:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rSNsZ-0002fW-2i
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:00:19 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rSNsW-00031T-03
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:00:18 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2dc7827a97so529867966b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 13:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1706043613; x=1706648413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TGOJsXOA91jiaT7uFt8hT/Kv4pjl6sQmG3/HHVAns4=;
 b=Lz8SUrNy8amaHIGdjqWlmQdgMnjYz3FBkNaaDWHvnJfHfdKYNlA3kGUZvin4E282eS
 uJjsk043aAX97+Yi+TCCdHkIbFTYcEJGq47t3EVuFVwhJg0dzBbZogC0kt6MBlCmEzoW
 40494VWv+JVNF51Bx+/nGpExoGYrfWSZSEfGsL71I2M52YRHfA0iDI8QRIWN6W93TacF
 roGdtTJwRjKfEio/lzdHEG+y/ufroRvlnyeUUU+/9GzVQ9GfYYaqSQIONMgGBr8Ea3UE
 FhK7M22ZAU9wXmLCYWEA/hMTWFtO3tFDR1ASuRZ1Izqre6GKlLRf4tZOhVu3jFEx0O+s
 Uk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706043613; x=1706648413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TGOJsXOA91jiaT7uFt8hT/Kv4pjl6sQmG3/HHVAns4=;
 b=Sd6QmzS9mu/vzF8t8XKQvEXKIOC78Cq8AYtwQC/mLDuiubTW0bk7/UgUNGV+293n4B
 jziYXN5olvgCIFoyhT2sTujCusoZK2HHWVABu/PO4C3pKUUcQ4mT+byTpgIfMTodxjEq
 iUj/MIN2IQQw3pf6AUOHv3GAAmi63bW95bz7DGtkOcEpb/Fk1BAwk8zd56QrQj3tvUau
 wySqSAQgzoM0D5sNba3dyoI7pFSbCRltcARCzmUT8yfZTZejScGrYFndFm77ysDLrdKb
 dnCoRNrx+y92gkwa6JAL6Bo0NlkITyRwB3oLxXdIqIvH8+AAOOrd0arXS0n2cP0gWt4v
 RHbA==
X-Gm-Message-State: AOJu0YxNC9K+DNCsw1nPrytt8nX+q45z89aFSqZ9SDEiNFkENyRH1K8R
 wcZ4dIjU+zImBDX78DoOlHPndvvvu3hLcyGzzL6yHUtdbswJvCML//aInbey0pQU62EI6Y/jeju
 xiAeUS1pznAIkH6oUa8PJCHto40y7JLYPaOGNYQ==
X-Google-Smtp-Source: AGHT+IEOpdq2g8BZUn6wIQrN8uU84X0teu3KVYor2QPVE53Z8295WEP54ngSQUKPOYgb3COB6N1fN1+79BzkpDKnSvw=
X-Received: by 2002:a17:906:3888:b0:a27:7c2e:420a with SMTP id
 q8-20020a170906388800b00a277c2e420amr274687ejd.8.1706043612978; Tue, 23 Jan
 2024 13:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
 <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
 <CAAYibXjw42iB=5YgKsXy4erj6RsGuqDqFnhuOZxkfBit7S5TtA@mail.gmail.com>
 <8734uof5kw.fsf@suse.de>
In-Reply-To: <8734uof5kw.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 23 Jan 2024 13:00:01 -0800
Message-ID: <CAAYibXjq2uRQkAAxecogUyxv9fKr785cAx_kN5KKeXttmx7jaw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 01/20] multifd: Add capability to
 enable/disable zero_page
To: Fabiano Rosas <farosas@suse.de>
Cc: Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 7:11=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Sun, Jan 14, 2024 at 10:02=E2=80=AFPM Shivam Kumar <shivam.kumar1@nu=
tanix.com> wrote:
> >>
> >>
> >>
> >> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrot=
e:
> >> >
> >> > From: Juan Quintela <quintela@redhat.com>
> >> >
> >> > We have to enable it by default until we introduce the new code.
> >> >
> >> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> > ---
> >> > migration/options.c | 15 +++++++++++++++
> >> > migration/options.h |  1 +
> >> > qapi/migration.json |  8 +++++++-
> >> > 3 files changed, 23 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/migration/options.c b/migration/options.c
> >> > index 8d8ec73ad9..0f6bd78b9f 100644
> >> > --- a/migration/options.c
> >> > +++ b/migration/options.c
> >> > @@ -204,6 +204,8 @@ Property migration_properties[] =3D {
> >> >     DEFINE_PROP_MIG_CAP("x-switchover-ack",
> >> >                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >> >     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_=
LIMIT),
> >> > +    DEFINE_PROP_MIG_CAP("main-zero-page",
> >> > +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
> >> >     DEFINE_PROP_END_OF_LIST(),
> >> > };
> >> >
> >> > @@ -284,6 +286,19 @@ bool migrate_multifd(void)
> >> >     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> >> > }
> >> >
> >> > +bool migrate_use_main_zero_page(void)
> >> > +{
> >> > +    /* MigrationState *s; */
> >> > +
> >> > +    /* s =3D migrate_get_current(); */
> >> > +
> >> > +    /*
> >> > +     * We will enable this when we add the right code.
> >> > +     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZER=
O_PAGE];
> >> > +     */
> >> > +    return true;
> >> > +}
> >> > +
> >> > bool migrate_pause_before_switchover(void)
> >> > {
> >> >     MigrationState *s =3D migrate_get_current();
> >> > diff --git a/migration/options.h b/migration/options.h
> >> > index 246c160aee..c901eb57c6 100644
> >> > --- a/migration/options.h
> >> > +++ b/migration/options.h
> >> > @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
> >> > MultiFDCompression migrate_multifd_compression(void);
> >> > int migrate_multifd_zlib_level(void);
> >> > int migrate_multifd_zstd_level(void);
> >> > +bool migrate_use_main_zero_page(void);
> >> > uint8_t migrate_throttle_trigger_threshold(void);
> >> > const char *migrate_tls_authz(void);
> >> > const char *migrate_tls_creds(void);
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index eb2f883513..80c4b13516 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -531,6 +531,12 @@
> >> > #     and can result in more stable read performance.  Requires KVM
> >> > #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >> > #
> >> > +#
> >> > +# @main-zero-page: If enabled, the detection of zero pages will be
> >> > +#                  done on the main thread.  Otherwise it is done o=
n
> >> > +#                  the multifd threads.
> >> > +#                  (since 8.2)
> >> > +#
> >> Should the capability name be something like "zero-page-detection" or =
just =E2=80=9Czero-page=E2=80=9D?
> >> CC: Fabiano Rosas
> >
> > I think the same concern was brought up last time Juan sent out the
> > original patchset. Right now, the zero page detection is done in the
> > main migration thread and it is always "ON". This change added a
> > functionality to move the zero page detection from the main thread to
> > the multifd sender threads. Now "main-zero-page" is turned "OFF" by
> > default, and zero page checking is done in the multifd sender thread
> > (much better performance). If user wants to run the zero page
> > detection in the main thread (keep current behavior), user can change
> > "main-zero-page" to "ON".
> >
> > Renaming it to "zero-page-detection" or just =E2=80=9Czero-page=E2=80=
=9D can not
> > differentiate the old behavior and the new behavior.
>
> Yes, the main point here is what happens when we try to migrate from
> different QEMU versions that have/don't have this code. We need some way
> to maintain the compatibility. In this case Juan chose to keep this
> capability with the semantics of "old behavior" so that we can enable it
> on the new QEMU to match with the old binary that doesn't expect to see
> zero pages on the packet/stream.
>
> > Here are the options:
> > 1) Keep the current behavior. "main-zero-page" is OFF by default and
> > zero page detection runs on the multifd thread by default. User can
> > turn the switch to "ON" if they want old behavior.
> > 2) Make "main-zero-page" switch ON as default. This would keep the
> > current behavior by default. User can set it to "OFF" for better
> > performance.
>
> 3) Make multifd-zero-page ON by default. User can set it to OFF to get
> the old behavior. There was some consideration about how libvirt works
> that would make this one unusable, but I don't understand what's that
> about.
>
> I would make this a default ON parameter instead of a capability.

Sounds good to me.

>
> >> > # Features:
> >> > #
> >> > # @deprecated: Member @block is deprecated.  Use blockdev-mirror wit=
h
> >> > @@ -555,7 +561,7 @@
> >> >            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] }=
,
> >> >            'validate-uuid', 'background-snapshot',
> >> >            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> >> > -           'dirty-limit'] }
> >> > +           'dirty-limit', 'main-zero-page'] }
> >> >
> >> > ##
> >> > # @MigrationCapabilityStatus:
> >> > --
> >> > 2.30.2
> >> >
> >> >
> >> >
> >>

