Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F78C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPTS-00078r-8v; Tue, 05 Mar 2024 02:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhPTO-00078O-4F
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhPTM-0007PN-Kd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709624663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URG2IugC5AhDOzExprd8f6SFF/Tg/yYfwBN8xzaSp2Y=;
 b=Knsc+QkOuqUX6Hz8SlSrp/WTI1KED3saborKvYvjiCQezDgD5KXXnxhmmmk7Lk5G5QvePs
 y5jtZCoQwyxceNbMainfodqaxaPVH5JLeF+Ge3aon3l12vCribzm8gKixhg8asVlZ8+iJw
 M2OHEP/e6VaU+lW0B/bSfz0aT1gB4jU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-TWdcY1VKPqemQIYyNBUtgw-1; Tue, 05 Mar 2024 02:44:22 -0500
X-MC-Unique: TWdcY1VKPqemQIYyNBUtgw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e0edcf4f4so1783246f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624661; x=1710229461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URG2IugC5AhDOzExprd8f6SFF/Tg/yYfwBN8xzaSp2Y=;
 b=UorMv9qLQUCI9xZxaxu9wxj08w+dz8EWVgTQNQlDGqQubf69f3SRQOiSlGgGujMfSN
 1dtJhWowPAZpW2a8ywvvEmVMiTA2hJme0ony5KjDAwKGmLna7vQJHu7tGVnEfSoVHYNL
 KZWkpF8NAtuJTETx3VBnmQCNV7wqPcuoQQ01bWEgapuz5UJtElgXbEoePaS6kzoSLzZ3
 WOWHnsi8LdDpcZZ5v6NR0RLtpcb51R5QE/iVc5Kpg0KYzmuVdCWauprLMhamog92858H
 oMnZGqidSm/5HNkJFPkuGik7YcbWeXGKmz6a+FUR0zuXp84duh41hHzWBZkna3v4MXSV
 H1Cw==
X-Gm-Message-State: AOJu0YxhOS2fKFO1/hnaxE2D/hNh2JfWvJzIlMMjXPCjGHrlm1w6sdFH
 gql40lMog8kqvucRZutU6+DMsklIFIYDxOofLckDdZH6cC6j34Fx1X2199KdT6yYtvLELj0iX9O
 i+MmKThAys0Z7GitrOhjfYvQaKQr9yK7czcih0DnA5HMKrty9Jx/4JygeVjE/vqVJF0A1eGqgG8
 9mDVRlcr5AzVx1co2qxkq0T9raKio=
X-Received: by 2002:a5d:6ac5:0:b0:33e:4d34:f40f with SMTP id
 u5-20020a5d6ac5000000b0033e4d34f40fmr179366wrw.46.1709624660978; 
 Mon, 04 Mar 2024 23:44:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWFEORdEsGJPb/nPnOdVSTrMcelBOPWelnZS02PHk+jxQBXGl3v9sng5QGWI6j/qNNxj/qF/MibfRUIAeCBms=
X-Received: by 2002:a5d:6ac5:0:b0:33e:4d34:f40f with SMTP id
 u5-20020a5d6ac5000000b0033e4d34f40fmr179350wrw.46.1709624660631; Mon, 04 Mar
 2024 23:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-6-clg@redhat.com>
In-Reply-To: <20240304122844.1888308-6-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Mar 2024 13:14:04 +0530
Message-ID: <CAE8KmOxN3mQAQuQK5UDe1oWBYxuSx1Ff=CVxT8_C7oLCrZ7Ctw@mail.gmail.com>
Subject: Re: [PATCH v3 05/26] migration: Add Error** argument to vmstate_save()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 4 Mar 2024 at 19:38, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> This will prepare ground for futur changes adding an Error** argument

* futur -> furure

>
> -static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmd=
esc)
> +static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmd=
esc,
> +                        Error **errp)
>  {
>      int ret;
> -    Error *local_err =3D NULL;
> -    MigrationState *s =3D migrate_get_current();
>
>      if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
>          return 0;
> @@ -1034,10 +1033,9 @@ static int vmstate_save(QEMUFile *f, SaveStateEntr=
y *se, JSONWriter *vmdesc)
>      if (!se->vmsd) {
>          vmstate_save_old_style(f, se, vmdesc);
>      } else {
> -        ret =3D vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmd=
esc, &local_err);
> +        ret =3D vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmd=
esc,
> +                                          errp);
>          if (ret) {
> -            migrate_set_error(s, local_err);
> -            error_report_err(local_err);
>              return ret;
>          }
>      }
> @@ -1324,8 +1322,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
>      trace_savevm_state_setup();
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
> -            ret =3D vmstate_save(f, se, ms->vmdesc);
> +            ret =3D vmstate_save(f, se, ms->vmdesc, &local_err);
>              if (ret) {
> +                migrate_set_error(ms, local_err);
> +                error_report_err(local_err);
>                  qemu_file_set_error(f, ret);
>                  break;
>              }
> @@ -1540,6 +1540,7 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
>      JSONWriter *vmdesc =3D ms->vmdesc;
>      int vmdesc_len;
>      SaveStateEntry *se;
> +    Error *local_err =3D NULL;
>      int ret;
>
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> @@ -1550,8 +1551,10 @@ int qemu_savevm_state_complete_precopy_non_iterabl=
e(QEMUFile *f,
>
>          start_ts_each =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>
> -        ret =3D vmstate_save(f, se, vmdesc);
> +        ret =3D vmstate_save(f, se, vmdesc, &local_err);
>          if (ret) {
> +            migrate_set_error(ms, local_err);
> +            error_report_err(local_err);
>              qemu_file_set_error(f, ret);
>              return ret;
>          }
> @@ -1566,7 +1569,6 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
>           * bdrv_activate_all() on the other end won't fail. */
>          ret =3D bdrv_inactivate_all();
>          if (ret) {
> -            Error *local_err =3D NULL;
>              error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d=
)",
>                         __func__, ret);
>              migrate_set_error(ms, local_err);
> @@ -1762,6 +1764,8 @@ void qemu_savevm_live_state(QEMUFile *f)
>
>  int qemu_save_device_state(QEMUFile *f)
>  {
> +    MigrationState *ms =3D migrate_get_current();
> +    Error *local_err =3D NULL;
>      SaveStateEntry *se;
>
>      if (!migration_in_colo_state()) {
> @@ -1776,8 +1780,10 @@ int qemu_save_device_state(QEMUFile *f)
>          if (se->is_ram) {
>              continue;
>          }
> -        ret =3D vmstate_save(f, se, NULL);
> +        ret =3D vmstate_save(f, se, NULL, &local_err);
>          if (ret) {
> +            migrate_set_error(ms, local_err);
> +            error_report_err(local_err);
>              return ret;
>          }
>      }
> --

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


