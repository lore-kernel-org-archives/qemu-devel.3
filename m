Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1FDC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 23:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT9Qt-00055C-4J; Thu, 25 Jan 2024 18:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rT9Qp-00054x-Fo
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 18:46:53 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rT9Ql-0007MI-CD
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 18:46:49 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso762721366b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1706226401; x=1706831201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V8KhNmyyCrRfAR68b2mVxxqek7uuAy8wq0xDY8eQS4=;
 b=buMurLB+D6ObBrltEsrwr3XmLNDdlGA0vYBcTmgcZkQMYCxGAv+yWLhXUGmslDwT+w
 niDlW14mqaXINU6C9/CiDIfMVp+qeB+TU6gsoKLJAI7VjycoxVW2Opx5JiUZIjBQ7/av
 SDqSyWJNgR/BczIEEihim1zxEbdiKY24Ucqio9jLbUyvgg9DEeKGgpJnexD5o/F31enE
 88+nFIMS6m6rhqdjyn+VuI7qpIj0syYk63k+Ph5vTPoxwoHyOPW8jKqyynZPDvM4C2gm
 xChVGX9fbak/WHaW7qMg55hqJEbLkIUM2TvJ76HRpIUvXXT6eEorzL/FS/yVkKmW5cEn
 8hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706226401; x=1706831201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8V8KhNmyyCrRfAR68b2mVxxqek7uuAy8wq0xDY8eQS4=;
 b=YemwC9OzKSGA89UyWRvFPkgM/+YpRGH+dJjUYtugky88eN5R5SpUUuxhwRQupsefaY
 yl2iAF9UMTNFm9czopmNV+IxRjP/AHj0KKNUyMGhHoioJQSFRsMHI/3h78ooe/hezHe1
 TLwwxyi0fS9v5CeSVcieViLbLph5lRXbZKdwrRBzBzHXj1jeeSB2jeRvLmf9z0yRHI5t
 stK91POi0e+UXH6g7muhYtD6ew6Mss1E8K1b9Eyg8fO6IIOS+j+dtWvVC+APbUWYZ2YF
 yhciigE5EodjU4/+WSNL4DKzChPW+A5Z6sR0CyGTOGk5Jr0VhSBLe2QmzCAHtc9h7pg0
 2CnQ==
X-Gm-Message-State: AOJu0YyQ89+06kqodw+zV6NmKRn7PX7QO0afpKQBcttaq3sUH4OrNjkI
 zsn487Bkjg5e5o8tgiEhBdPR3TEeNFowa+8VSDL47dBihMKZjzYT26viwLsQCl7hO/DGaCfO5PG
 ncBy6f939xSPXdZW3AiFUVghSayPTb4bAIUkySQ==
X-Google-Smtp-Source: AGHT+IHvA3L3Cm9ZHR/aP+jAFjUQoA7oF2oT28c9K9asRTw1Bpts5ybf8RB0jhhJb5V/lkDgDS3vTfvYYMaBezAZtP8=
X-Received: by 2002:a17:906:481b:b0:a2f:e50b:ac3c with SMTP id
 w27-20020a170906481b00b00a2fe50bac3cmr196113ejq.29.1706226401209; Thu, 25 Jan
 2024 15:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-5-hao.xiang@bytedance.com> <87pm09ennn.fsf@suse.de>
 <CAAYibXiD5Ni4Dh8=K-iXAuv9sx_LpxXd8ZkA3XP_dJy+P7J7Sw@mail.gmail.com>
 <CAAYibXgtVP-w02Jiy-JM8JZBj2h4jxvwnmeM6VvfycxY09jxzQ@mail.gmail.com>
 <877cjxvwe0.fsf@suse.de>
In-Reply-To: <877cjxvwe0.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 25 Jan 2024 15:46:30 -0800
Message-ID: <CAAYibXi=WB5wfvLFM0b=d9oJf66Lb7FTGoNzzZ-tvK4RbBXxDw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 04/20] So we use multifd to transmit
 zero pages.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62c.google.com
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

On Thu, Jan 25, 2024 at 3:14=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Mon, Jan 22, 2024 at 8:28=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.=
com> wrote:
> >>
> >> On Thu, Nov 16, 2023 at 7:14=E2=80=AFAM Fabiano Rosas <farosas@suse.de=
> wrote:
> >> >
> >> > Hao Xiang <hao.xiang@bytedance.com> writes:
> >> >
> >> > > From: Juan Quintela <quintela@redhat.com>
> >> > >
> >> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> > > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> >> > > ---
> >> > >  migration/multifd.c |  7 ++++---
> >> > >  migration/options.c | 13 +++++++------
> >> > >  migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++--=
-----
> >> > >  qapi/migration.json |  1 -
> >> > >  4 files changed, 49 insertions(+), 17 deletions(-)
> >> > >
> >> > > diff --git a/migration/multifd.c b/migration/multifd.c
> >> > > index 1b994790d5..1198ffde9c 100644
> >> > > --- a/migration/multifd.c
> >> > > +++ b/migration/multifd.c
> >> > > @@ -13,6 +13,7 @@
> >> > >  #include "qemu/osdep.h"
> >> > >  #include "qemu/cutils.h"
> >> > >  #include "qemu/rcu.h"
> >> > > +#include "qemu/cutils.h"
> >> > >  #include "exec/target_page.h"
> >> > >  #include "sysemu/sysemu.h"
> >> > >  #include "exec/ramblock.h"
> >> > > @@ -459,7 +460,6 @@ static int multifd_send_pages(QEMUFile *f)
> >> > >      p->packet_num =3D multifd_send_state->packet_num++;
> >> > >      multifd_send_state->pages =3D p->pages;
> >> > >      p->pages =3D pages;
> >> > > -
> >> > >      qemu_mutex_unlock(&p->mutex);
> >> > >      qemu_sem_post(&p->sem);
> >> > >
> >> > > @@ -684,7 +684,7 @@ static void *multifd_send_thread(void *opaque)
> >> > >      MigrationThread *thread =3D NULL;
> >> > >      Error *local_err =3D NULL;
> >> > >      /* qemu older than 8.2 don't understand zero page on multifd =
channel */
> >> > > -    bool use_zero_page =3D !migrate_use_main_zero_page();
> >> > > +    bool use_multifd_zero_page =3D !migrate_use_main_zero_page();
> >> > >      int ret =3D 0;
> >> > >      bool use_zero_copy_send =3D migrate_zero_copy_send();
> >> > >
> >> > > @@ -713,6 +713,7 @@ static void *multifd_send_thread(void *opaque)
> >> > >              RAMBlock *rb =3D p->pages->block;
> >> > >              uint64_t packet_num =3D p->packet_num;
> >> > >              uint32_t flags;
> >> > > +
> >> > >              p->normal_num =3D 0;
> >> > >              p->zero_num =3D 0;
> >> > >
> >> > > @@ -724,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
> >> > >
> >> > >              for (int i =3D 0; i < p->pages->num; i++) {
> >> > >                  uint64_t offset =3D p->pages->offset[i];
> >> > > -                if (use_zero_page &&
> >> > > +                if (use_multifd_zero_page &&
> >> >
> >> > We could have a new function in multifd_ops for zero page
> >> > handling. We're already considering an accelerator for the compressi=
on
> >> > method in the other series[1] and in this series we're adding an
> >> > accelerator for zero page checking. It's about time we make the
> >> > multifd_ops generic instead of only compression/no compression.
> >>
> >> Sorry I overlooked this email earlier.
> >> I will extend the multifd_ops interface and add a new API for zero
> >> page checking.
> >>
> >> >
> >> > 1- [PATCH v2 0/4] Live Migration Acceleration with IAA Compression
> >> > https://lore.kernel.org/r/20231109154638.488213-1-yuan1.liu@intel.co=
m
> >> >
> >> > >                      buffer_is_zero(rb->host + offset, p->page_siz=
e)) {
> >> > >                      p->zero[p->zero_num] =3D offset;
> >> > >                      p->zero_num++;
> >> > > diff --git a/migration/options.c b/migration/options.c
> >> > > index 00c0c4a0d6..97d121d4d7 100644
> >> > > --- a/migration/options.c
> >> > > +++ b/migration/options.c
> >> > > @@ -195,6 +195,7 @@ Property migration_properties[] =3D {
> >> > >      DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
> >> > >      DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RET=
URN_PATH),
> >> > >      DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD=
),
> >> > > +    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_=
MAIN_ZERO_PAGE),
> >> > >      DEFINE_PROP_MIG_CAP("x-background-snapshot",
> >> > >              MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
> >> > >  #ifdef CONFIG_LINUX
> >> > > @@ -288,13 +289,9 @@ bool migrate_multifd(void)
> >> > >
> >> > >  bool migrate_use_main_zero_page(void)
> >> > >  {
> >> > > -    //MigrationState *s;
> >> > > -
> >> > > -    //s =3D migrate_get_current();
> >> > > +    MigrationState *s =3D migrate_get_current();
> >> > >
> >> > > -    // We will enable this when we add the right code.
> >> > > -    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_Z=
ERO_PAGE];
> >> > > -    return true;
> >> > > +    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
> >> >
> >> > What happens if we disable main-zero-page while multifd is not enabl=
ed?
> >>
> >> In ram.c
> >> ...
> >> if (migrate_multifd() && !migrate_use_main_zero_page()) {
> >> migration_ops->ram_save_target_page =3D ram_save_target_page_multifd;
> >> } else {
> >> migration_ops->ram_save_target_page =3D ram_save_target_page_legacy;
> >> }
> >> ...
> >>
> >> So if main-zero-page is disabled and multifd is also disabled, it will
> >> go with the "else" path, which is the legacy path
> >> ram_save_target_page_legacy() and do zero page checking from the main
> >> thread.
> >>
> >> >
> >> > >  }
> >> > >
> >> > >  bool migrate_pause_before_switchover(void)
> >> > > @@ -457,6 +454,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_backgro=
und_snapshot,
> >> > >      MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
> >> > >      MIGRATION_CAPABILITY_RETURN_PATH,
> >> > >      MIGRATION_CAPABILITY_MULTIFD,
> >> > > +    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
> >> > >      MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
> >> > >      MIGRATION_CAPABILITY_AUTO_CONVERGE,
> >> > >      MIGRATION_CAPABILITY_RELEASE_RAM,
> >> > > @@ -534,6 +532,9 @@ bool migrate_caps_check(bool *old_caps, bool *=
new_caps, Error **errp)
> >> > >              error_setg(errp, "Postcopy is not yet compatible with=
 multifd");
> >> > >              return false;
> >> > >          }
> >> > > +        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
> >> > > +            error_setg(errp, "Postcopy is not yet compatible with=
 main zero copy");
> >> > > +        }
> >> >
> >> > Won't this will breaks compatibility for postcopy? A command that us=
ed
> >> > to work now will have to disable main-zero-page first.
> >>
> >> main-zero-page is disabled by default.
> >>
> >> >
> >> > >      }
> >> > >
> >> > >      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> >> > > diff --git a/migration/ram.c b/migration/ram.c
> >> > > index 8c7886ab79..f7a42feff2 100644
> >> > > --- a/migration/ram.c
> >> > > +++ b/migration/ram.c
> >> > > @@ -2059,17 +2059,42 @@ static int ram_save_target_page_legacy(RAM=
State *rs, PageSearchStatus *pss)
> >> > >      if (save_zero_page(rs, pss, offset)) {
> >> > >          return 1;
> >> > >      }
> >> > > -
> >> > >      /*
> >> > > -     * Do not use multifd in postcopy as one whole host page shou=
ld be
> >> > > -     * placed.  Meanwhile postcopy requires atomic update of page=
s, so even
> >> > > -     * if host page size =3D=3D guest page size the dest guest du=
ring run may
> >> > > -     * still see partially copied pages which is data corruption.
> >> > > +     * Do not use multifd for:
> >> > > +     * 1. Compression as the first page in the new block should b=
e posted out
> >> > > +     *    before sending the compressed page
> >> > > +     * 2. In postcopy as one whole host page should be placed
> >> > >       */
> >> > > -    if (migrate_multifd() && !migration_in_postcopy()) {
> >> > > +    if (!migrate_compress() && migrate_multifd() && !migration_in=
_postcopy()) {
> >> > > +        return ram_save_multifd_page(pss->pss_channel, block, off=
set);
> >> > > +    }
> >> >
> >> > This could go into ram_save_target_page_multifd like so:
> >> >
> >> > if (!migrate_compress() && !migration_in_postcopy() && !migration_ma=
in_zero_page()) {
> >> >     return ram_save_multifd_page(pss->pss_channel, block, offset);
> >> > } else {
> >> >   return ram_save_target_page_legacy();
> >> > }
> >> >
> >> > > +
> >> > > +    return ram_save_page(rs, pss);
> >> > > +}
> >> > > +
> >> > > +/**
> >> > > + * ram_save_target_page_multifd: save one target page
> >> > > + *
> >> > > + * Returns the number of pages written
> >> > > + *
> >> > > + * @rs: current RAM state
> >> > > + * @pss: data about the page we want to send
> >> > > + */
> >> > > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchS=
tatus *pss)
> >> > > +{
> >> > > +    RAMBlock *block =3D pss->block;
> >> > > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_=
BITS;
> >> > > +    int res;
> >> > > +
> >> > > +    if (!migration_in_postcopy()) {
> >> > >          return ram_save_multifd_page(pss->pss_channel, block, off=
set);
> >> > >      }
> >> > >
> >> > > +    res =3D save_zero_page(rs, pss, offset);
> >> > > +    if (res > 0) {
> >> > > +        return res;
> >> > > +    }
> >> > > +
> >> > >      return ram_save_page(rs, pss);
> >> > >  }
> >> > >
> >> > > @@ -2982,9 +3007,15 @@ static int ram_save_setup(QEMUFile *f, void=
 *opaque)
> >> > >      }
> >> > >
> >> > >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> >> > > -    migration_ops->ram_save_target_page =3D ram_save_target_page_=
legacy;
> >> > > +
> >> > > +    if (migrate_multifd() && !migrate_use_main_zero_page()) {
> >> > > +        migration_ops->ram_save_target_page =3D ram_save_target_p=
age_multifd;
> >> > > +    } else {
> >> > > +        migration_ops->ram_save_target_page =3D ram_save_target_p=
age_legacy;
> >> > > +    }
> >> >
> >> > This should not check main-zero-page. Just have multifd vs. legacy a=
nd
> >> > have the multifd function defer to _legacy if main-zero-page or
> >> > in_postcopy.
> >>
> >> I noticed that ram_save_target_page_legacy and
> >> ram_save_target_page_multifd have a lot of overlap and are quite
> >> confusing. I can refactor this path and take-in your comments here.
> >>
> >> 1) Remove ram_save_multifd_page() call from
> >> ram_save_target_page_legacy(). ram_save_multifd_page() will only be
> >> called in ram_save_target_page_multifd().
> >> 2) Remove save_zero_page() and ram_save_page() from
> >> ram_save_target_page_multifd().
> >> 3) Postcopy will always go with the ram_save_target_page_legacy() path=
.
> >> 4) Legacy compression will always go with the
> >> ram_save_target_page_legacy() path.
> >> 5) Call ram_save_target_page_legacy() from within
> >> ram_save_target_page_multifd() if postcopy or legacy compression.
> >>
> >
> > Hi Fabiano,
> > So I spent some time reading the
> > ram_save_target_page_legacy/ram_save_target_page_multifd code path
> > Juan wrote and here is my current understanding:
> > 1) Multifd and legacy compression are not compatible.
> > 2) Multifd and postcopy are not compatible.
> > The compatibility checks are implemented in migrate_caps_check(). So
> > there is really no need to handle a lot of the complexity in Juan's
> > code.
> >
> > I think what we can do is:
> > 1) If multifd is enabled, use ram_save_target_page_multifd().
> > Otherwise, use ram_save_target_page_legacy().
> > 2) In ram_save_target_page_legacy(), we don't need the special path to
> > call ram_save_multifd_page(). That can be handled by
> > ram_save_target_page_multifd() alone.
> > 3) In ram_save_target_page_multifd(), we assert that legacy
> > compression is not enabled. And we also assert that postcopy is also
> > not enabled.
> > 4) We do need backward compatibility support for the main zero page
> > checking case in multifd. So in ram_save_target_page_multifd(), we
> > call save_zero_page() if migrate_multifd_zero_page() is false.
> >
>
> Sounds good. Could you apply those changes and the capability we
> discussed in the other message and send a separate series?  I haven't
> found the time to work on this yet.
>

Sure, I will send out a separate series for multifd zero page checking.

