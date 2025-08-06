Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F8C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZCs-00071o-85; Wed, 06 Aug 2025 04:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZBZ-0005Rr-Kj
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZBX-0004Az-8q
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754467662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hUDo5X0ZOcTQj+Zf5Nl5QvLGErdQueemoqy08tWpjhU=;
 b=LxLZbEz/j10fEBzZvlNEgW/ElPNy7cAeldJQuzsrgN4GyuUrKVLi3dPKJ6jY23UMagCTTb
 y3WQWT78/juhzv/U/avZsoCscXdecsSAejIY86uuLac06NQ5Yk9g6NhUi4Sd/gvXMQa+6M
 K9/Xjs0hRZKYC/laoUQCYo9NIghh6TY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-2xG5Je4GNbKavI3qa_C9aQ-1; Wed, 06 Aug 2025 04:07:38 -0400
X-MC-Unique: 2xG5Je4GNbKavI3qa_C9aQ-1
X-Mimecast-MFC-AGG-ID: 2xG5Je4GNbKavI3qa_C9aQ_1754467657
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3211b736a11so7348803a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 01:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754467657; x=1755072457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUDo5X0ZOcTQj+Zf5Nl5QvLGErdQueemoqy08tWpjhU=;
 b=keQ+H86MuEiITaXKS272rkv/E3VAV6VnLpIULxsI9pZnCVM5wxjkmuvImFXve2/Grn
 w/GbR+iwN5BOs1Z3aKqwDjFwaPCrYi2VGmz/Xlu618c85bycckg2yp89pifBzJolmCTC
 eIND9kbgwwXSOELev0hBUZpXwO7Q0Fr5xi2L4tyQzoh0Ddmf90cAGksP/Ehjbie8ZQVH
 xNiNumsJ8QDrNX9qaGQ8fkF0SU8rkQhP/FiOJ/vxD3b/1hJSRa7XmY1siFIC43bNlY4s
 7JtXeJvxAkF3stRxRKnaKmV2Dc4KnA43vdrWl+fVgOsepzTJHACnwi1xX90UJfDPBiDd
 +XOA==
X-Gm-Message-State: AOJu0Yw40hC4Ywx9ilTk929oEMGFFaMsTxZMO2aeFhuWi8OdQhzUk3Mk
 ZThT+ZxKZCFf6k3tJv8noA99+947FiezXXnyGSSub/+JT/LhwVqqSoiE+kSPjjeIK/plBntFKDJ
 P13/BggDmdoOSPja4lD3O+k+Fe5fWTJ1JjHF7QQPu7vqWfu80nmUtA4cJ6nLViosO8+xZyoibQR
 stZSNC/EARUUgkzr4yXLSbW6IvHbTS6i8=
X-Gm-Gg: ASbGncs2z7LMGkLV0N0P46/dFoq3pL1G2I2EMd+LIUq7SSxwyb+tlRRolu1QUq9lHaI
 AF81plTXQyUCKJgomE3dvn2nbFcgr+RkEa0vUvSoal43tFSWKzVbS4kNl/ZVkKY7kcH7RZsQ8Xk
 58RuwUv2aP7lZP8Ezl1v+Nta1LR1Mivt8ca8pi/be/NFvWxmwwBbRbaQ==
X-Received: by 2002:a17:90b:4a01:b0:31f:762c:bc25 with SMTP id
 98e67ed59e1d1-32166cc888bmr2032198a91.25.1754467657179; 
 Wed, 06 Aug 2025 01:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9JfbVsnaSpwQewzpcDRjjR0UMcmJBJwrB0I5OP+TakaR+/ANNfsx8bfuChYLGxqIMzZMPExUV4mh1zWtj6c=
X-Received: by 2002:a17:90b:4a01:b0:31f:762c:bc25 with SMTP id
 98e67ed59e1d1-32166cc888bmr2032146a91.25.1754467656678; Wed, 06 Aug 2025
 01:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-20-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-20-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 12:07:25 +0400
X-Gm-Features: Ac12FXwdbs8kiJka5NHuU8RNHjLTf5dl20cAU069ABFPwqyzo-nbU18on1YoVnc
Message-ID: <CAMxuvazyJ89i=Yw1j49hSCmBvnuqeB+dMG3ms0=NjzhaB9Uw-A@mail.gmail.com>
Subject: Re: [PATCH v9 20/27] migration: push Error **errp into
 loadvm_process_enable_colo()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000072604e063badd5cd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000072604e063badd5cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:31=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_process_enable_colo() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/migration/colo.h |  2 +-
>  migration/migration.c    | 12 ++++++------
>  migration/ram.c          |  8 ++++----
>  migration/ram.h          |  2 +-
>  migration/savevm.c       | 26 ++++++++++++++------------
>  5 files changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index
> 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fc=
d73287a0e
> 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
>  bool migration_in_colo_state(void);
>
>  /* loadvm */
> -int migration_incoming_enable_colo(void);
> +int migration_incoming_enable_colo(Error **errp);
>  void migration_incoming_disable_colo(void);
>  bool migration_incoming_colo_enabled(void);
>  bool migration_incoming_in_colo_state(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index
> 6962dc7d7f3e0121d28994c98f12f9f2258343d7..4a76d7ed730589bae87115368b0bf48=
19f8b161e
> 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
>      migration_colo_enabled =3D false;
>  }
>
> -int migration_incoming_enable_colo(void)
> +int migration_incoming_enable_colo(Error **errp)
>  {
>  #ifndef CONFIG_REPLICATION
> -    error_report("ENABLE_COLO command come in migration stream, but the =
"
> -                 "replication module is not built in");
> +    error_setg(errp, "ENABLE_COLO command come in migration stream, but
> the "
> +               "replication module is not built in");
>      return -ENOTSUP;
>  #endif
>
>      if (!migrate_colo()) {
> -        error_report("ENABLE_COLO command come in migration stream, but
> x-colo "
> -                     "capability is not set");
> +        error_setg(errp, "ENABLE_COLO command come in migration stream"
> +                   ", but x-colo capability is not set");
>          return -EINVAL;
>      }
>
>      if (ram_block_discard_disable(true)) {
> -        error_report("COLO: cannot disable RAM discard");
> +        error_setg(errp, "COLO: cannot disable RAM discard");
>          return -EBUSY;
>      }
>      migration_colo_enabled =3D true;
> diff --git a/migration/ram.c b/migration/ram.c
> index
> 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664d62e=
18c1afd90
> 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
>   * memory of the secondary VM, it is need to hold the global lock
>   * to call this helper.
>   */
> -int colo_init_ram_cache(void)
> +int colo_init_ram_cache(Error **errp)
>  {
>      RAMBlock *block;
>
> @@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
>              block->colo_cache =3D qemu_anon_ram_alloc(block->used_length=
,
>                                                      NULL, false, false);
>              if (!block->colo_cache) {
> -                error_report("%s: Can't alloc memory for COLO cache of
> block %s,"
> -                             "size 0x" RAM_ADDR_FMT, __func__,
> block->idstr,
> -                             block->used_length);
> +                error_setg(errp, "Can't alloc memory for COLO cache of "
> +                           "block %s, size 0x" RAM_ADDR_FMT,
> +                           block->idstr, block->used_length);
>                  RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>                      if (block->colo_cache) {
>                          qemu_anon_ram_free(block->colo_cache,
> block->used_length);
> diff --git a/migration/ram.h b/migration/ram.h
> index
> 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6ba=
eea2f0627
> 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block,
> ram_addr_t offset,
>                                     bool set);
>
>  /* ram cache */
> -int colo_init_ram_cache(void);
> +int colo_init_ram_cache(Error **errp);
>  void colo_flush_ram_cache(void);
>  void colo_release_ram_cache(void);
>  void colo_incoming_start_dirty_log(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 938adb20270adbf9546b0884d0877c25c3f0f816..a6b71a958aeda31e89043f8103bfe2f=
c89542fb5
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2519,15 +2519,21 @@ static int
> loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>      return 0;
>  }
>
> -static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> +static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> +                                      Error **errp)
>  {
> -    int ret =3D migration_incoming_enable_colo();
> +    ERRP_GUARD();
> +    int ret;
>
> -    if (!ret) {
> -        ret =3D colo_init_ram_cache();
> -        if (ret) {
> -            migration_incoming_disable_colo();
> -        }
> +    ret =3D migration_incoming_enable_colo(errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D colo_init_ram_cache(errp);
> +    if (ret) {
>

Note: here you keep the "ret" error condition !=3D0, ok.

colo_init_ram_cache(), returns -errno on error. Although errno should
remain unchanged on success (during qemu_anon_ram_free etc), I think it
would be safer to convert the function to follow the recommended
bool-valued function for true on success / false on failure instead.


> +        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
> +        migration_incoming_disable_colo();
>
     }
>      return ret;
>  }
> @@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f,
> Error **errp)
>          return loadvm_handle_recv_bitmap(mis, len, errp);
>
>      case MIG_CMD_ENABLE_COLO:
> -        ret =3D loadvm_process_enable_colo(mis);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to load device state command: %d",
> ret);
> -        }
> -        return ret;
> +        return loadvm_process_enable_colo(mis, errp);
>
>      case MIG_CMD_SWITCHOVER_START:
>          ret =3D loadvm_postcopy_handle_switchover_start();
>
> --
> 2.50.1
>
>

--00000000000072604e063badd5cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 20=
25 at 10:31=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This is an incremental step in converting vmstate loadin=
g<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that loadvm_process_enable_colo() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/migration/colo.h |=C2=A0 2 +-<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 | 12 ++++++------<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++----<=
br>
=C2=A0migration/ram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 26 ++++++++++++++-----=
-------<br>
=C2=A05 files changed, 26 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/include/migration/colo.h b/include/migration/colo.h<br>
index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f564=
00fcd73287a0e 100644<br>
--- a/include/migration/colo.h<br>
+++ b/include/migration/colo.h<br>
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);<br>
=C2=A0bool migration_in_colo_state(void);<br>
<br>
=C2=A0/* loadvm */<br>
-int migration_incoming_enable_colo(void);<br>
+int migration_incoming_enable_colo(Error **errp);<br>
=C2=A0void migration_incoming_disable_colo(void);<br>
=C2=A0bool migration_incoming_colo_enabled(void);<br>
=C2=A0bool migration_incoming_in_colo_state(void);<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 6962dc7d7f3e0121d28994c98f12f9f2258343d7..4a76d7ed730589bae87115368b0=
bf4819f8b161e 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)<br>
=C2=A0 =C2=A0 =C2=A0migration_colo_enabled =3D false;<br>
=C2=A0}<br>
<br>
-int migration_incoming_enable_colo(void)<br>
+int migration_incoming_enable_colo(Error **errp)<br>
=C2=A0{<br>
=C2=A0#ifndef CONFIG_REPLICATION<br>
-=C2=A0 =C2=A0 error_report(&quot;ENABLE_COLO command come in migration str=
eam, but the &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;replic=
ation module is not built in&quot;);<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;ENABLE_COLO command come in migration=
 stream, but the &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;replication m=
odule is not built in&quot;);<br>
=C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!migrate_colo()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;ENABLE_COLO command come in=
 migration stream, but x-colo &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;capability is not set&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;ENABLE_COLO command com=
e in migration stream&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;, but x-colo capability is not set&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ram_block_discard_disable(true)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;COLO: cannot disable RAM di=
scard&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;COLO: cannot disable RA=
M discard&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0migration_colo_enabled =3D true;<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664=
d62e18c1afd90 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)<br>
=C2=A0 * memory of the secondary VM, it is need to hold the global lock<br>
=C2=A0 * to call this helper.<br>
=C2=A0 */<br>
-int colo_init_ram_cache(void)<br>
+int colo_init_ram_cache(Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
<br>
@@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;colo_cache =3D qe=
mu_anon_ram_alloc(block-&gt;used_length,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, false, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!block-&gt;colo_cache) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot=
;%s: Can&#39;t alloc memory for COLO cache of block %s,&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;size 0x&quot; RAM_ADDR_FMT, __func__, =
block-&gt;idstr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;used_length);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &=
quot;Can&#39;t alloc memory for COLO cache of &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;block %s, size 0x&quot; RAM_ADDR_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;idstr, block-&gt;used_length);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RAMBLOCK_FORE=
ACH_NOT_IGNORED(block) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (block-&gt;colo_cache) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qemu_anon_ram_free(block-&gt;colo_cache, block-&gt;used_le=
ngth);<br>
diff --git a/migration/ram.h b/migration/ram.h<br>
index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03=
c6baeea2f0627 100644<br>
--- a/migration/ram.h<br>
+++ b/migration/ram.h<br>
@@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram=
_addr_t offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool set);<br>
<br>
=C2=A0/* ram cache */<br>
-int colo_init_ram_cache(void);<br>
+int colo_init_ram_cache(Error **errp);<br>
=C2=A0void colo_flush_ram_cache(void);<br>
=C2=A0void colo_release_ram_cache(void);<br>
=C2=A0void colo_incoming_start_dirty_log(void);<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 938adb20270adbf9546b0884d0877c25c3f0f816..a6b71a958aeda31e89043f8103b=
fe2fc89542fb5 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2519,15 +2519,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
ingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)<br>
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<b=
r>
=C2=A0{<br>
-=C2=A0 =C2=A0 int ret =3D migration_incoming_enable_colo();<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+=C2=A0 =C2=A0 int ret;<br>
<br>
-=C2=A0 =C2=A0 if (!ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D colo_init_ram_cache();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_incoming_disable_colo(=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D migration_incoming_enable_colo(errp);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D colo_init_ram_cache(errp);<br>
+=C2=A0 =C2=A0 if (ret) {<br></blockquote><div><br></div><div>Note: here yo=
u keep the &quot;ret&quot; error condition !=3D0, ok.=C2=A0</div><div><br><=
/div><div>colo_init_ram_cache(),=C2=A0returns -errno on error. Although err=
no should remain unchanged on success (during=C2=A0qemu_anon_ram_free etc),=
 I think it would be safer to convert the function to follow the recommende=
d bool-valued function for true on success=C2=A0/ false on failure instead.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;failed to init colo =
RAM cache: %d: &quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_incoming_disable_colo();<br></blockq=
uote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
@@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_handle_recv_bitmap(mis, len=
, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_ENABLE_COLO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_enable_colo(mis);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_process_enable_colo(mis, errp);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_SWITCHOVER_START:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D loadvm_postcopy_handle_switchover=
_start();<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--00000000000072604e063badd5cd--


