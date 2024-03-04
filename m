Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 09:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh4ru-0006bN-Bc; Mon, 04 Mar 2024 04:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh4rs-0006at-Cj
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh4rq-0000AX-R0
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709545456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDdTEQwD6nOXb+ZUeLHLv5IucqkQlO2++fN2l0/hk1Q=;
 b=ZG8bqD1/2uaQ8W0q6OMKdKkDF2SUUL5ybMt5aRJm23t5+OOMQyBEyXRphBDXVW4qxJjY7S
 jpv5Kfxgr3G5IGml8Kg3cWs0aRw4N4njLjALxmiUMZnF6rwETcMvVtF3yY16fOaJM68iTB
 5ncAh0y7QBcqCtcz+HDe2vLowV8uzEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-sUJjqkr1PZK_esSEZe08qA-1; Mon, 04 Mar 2024 04:44:13 -0500
X-MC-Unique: sUJjqkr1PZK_esSEZe08qA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d19951a9bso1577836f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 01:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709545452; x=1710150252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDdTEQwD6nOXb+ZUeLHLv5IucqkQlO2++fN2l0/hk1Q=;
 b=JlMfbQpwXyzxVIAzI+TCLrykeIGYI+N4CRH8ApTbjv+rEAZx4TxPX8R3VOgyesRBjl
 JOIxbYkFr3IlKTiCqiDJC0/V4pnu4nVYVKApH/hbtia6NHE8fdgrck0SyWxE7xNHUTDy
 tvrls7mYrdysHZEUttxktN4YRKNa8IF7q8GhUh7V2Q02NHZ5wCW7Ju/QeBMeALGJCrSN
 4MDx+JBXrZJgjHW2Oh7yGkNKIjCZyWhy2v0qbV8FgxAjZXm1YhyM/QaDhbxRU1J5zjaL
 4vH2mXwM7aYgoTq8f2mALmA/dFMuEmu9iObN+Cm1/c4tyyrd4qCcIHTxlopymdtgpa+Z
 LksA==
X-Gm-Message-State: AOJu0Yy5EeWFXJHZ5qhQ5Jjnt8KiVnmuvzF4haOzrg4dzcVO8rHaZuUP
 re1fZt/wl+Lcz4CkTYseuRyIxFPQ/BI3nOOeS9mu/Pki9DolRprilqFRnNIwkbiO28XNhJ0jd88
 p/7kVhqmK3YH5+Zhld10hZfLceluM5wC6CkUnP5K5l59tdqE3j2MAP0BQX3fx4zKqa70jgKuM1s
 SprbobWOMk675bPL5APt+JTm6J6YM=
X-Received: by 2002:adf:f3ca:0:b0:33e:193d:5156 with SMTP id
 g10-20020adff3ca000000b0033e193d5156mr5985117wrp.63.1709545452550; 
 Mon, 04 Mar 2024 01:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP+Beog7lXU61GXx8YtkJzrsx3l8/wPonLBLc2xL+7pKorc5cSOb05oWHtgB6KF7npqr5C1T6hF6b+QiLfZB4=
X-Received: by 2002:adf:f3ca:0:b0:33e:193d:5156 with SMTP id
 g10-20020adff3ca000000b0033e193d5156mr5985096wrp.63.1709545452234; Mon, 04
 Mar 2024 01:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-7-zhenzhong.duan@intel.com>
 <CAE8KmOxFnzsw2das+Go_EEyVUr517hWS8xvXfN1VoJq0RofR+w@mail.gmail.com>
 <SJ0PR11MB6744A22D240CB8A41569222392232@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744A22D240CB8A41569222392232@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Mar 2024 15:13:55 +0530
Message-ID: <CAE8KmOwuTpFSr=ft2cdiWKJmiy2uZMunO+v1UWFa1MbGqCXH7g@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, 
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

On Mon, 4 Mar 2024 at 13:41, Duan, Zhenzhong <zhenzhong.duan@intel.com> wro=
te:
> This is to deal with a special case when cold plugged vfio device is unpl=
ugged
> at runtime, then migration triggers.
>
> When qemu on source side starts with cold plugged vfio device, vIOMMU

qemu -> QEMU

> capability/extended capability registers(cap/ecap) can be updated based
> on host cap/ecap, then vIOMMU cap/ecap is frozen after machine creation
> done, vIOMMU cap/ecap isn=E2=80=99t restored to default after vfio device=
 is unplugged.
> In this case source and dest(default cap/ecap) will have incompatible cap=
/ecap
> value. So migration is blocked if there is cap/ecap update on source side=
.
>
> If vfio device isn't unplugged at runtime, vfio device's own vIOMMU migra=
tion blocker
> is redundant with blocker here, but that's harmless.
>
> If vfio devices are all hot plugged after qemu on source side starts, the=
n vIOMMU
> cap/ecap is frozen with the default value, we don't make a blocker in thi=
s case.
>

Nice +1

> >> @@ -3861,8 +3864,17 @@ static int
> >vtd_check_iommufd_hdev(IntelIOMMUState *s,
> >>          tmp_cap |=3D VTD_CAP_MGAW(host_mgaw + 1);
> >>      }
> >>
> >> -    s->cap =3D tmp_cap;
> >> -    return 0;
> >> +    if (s->cap !=3D tmp_cap) {
> >> +        if (vtd_mig_blocker =3D=3D NULL) {
> >> +            error_setg(&vtd_mig_blocker,
> >> +                       "cap/ecap update from host IOMMU block migrati=
on");
> >> +            ret =3D migrate_add_blocker(&vtd_mig_blocker, errp);
> >> +        }
> >> +        if (!ret) {
> >> +            s->cap =3D tmp_cap;
> >> +        }
> >> +    }
> >> +    return ret;
>
> vtd_mig_blocker !=3D NULL means cap is already updated once at least.
> In this case, ret is return value 0 from iommufd_device_get_info().
>
>     ret =3D iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd, errp)=
;
>     if (ret) {
>         return ret;
>     }
>
> Then cap is updated with host cap value tmp_cap. This update only happen
> before machine creation done.

* After iommufd_device_get_info() ret is !=3D 0. So s->cap won't be
updated then. Hope that is intended.

* With the above tweaks included:
    Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


