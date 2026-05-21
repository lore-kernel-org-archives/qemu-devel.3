Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA28CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4yB-00051b-Oz; Thu, 21 May 2026 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ4y8-0004zq-GC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ4y6-0000g0-KW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779375949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Q3t9Yeuq6DxysLkqSMiJKmEcJ7HmX7zk0pzvucmdbk=;
 b=L80nNrMR3k5FYTI6fB/XQqtxzSbPXvhP51TIYo6Q5VhS62R5t4L5/UQ8a6hZ/YuIEJwUnV
 Q6a3r6QhhmvaRwxVL3lFvIkBoNyYM/WgnipSdjyyH1nS6ksJ6DoQjp11YTXSOSMTqU1uiV
 1tz/3+ruxL2wONK46tPXLN4ODQDUfVY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-OdIyKrlsPcmBR6PMPO3nbA-1; Thu, 21 May 2026 11:05:48 -0400
X-MC-Unique: OdIyKrlsPcmBR6PMPO3nbA-1
X-Mimecast-MFC-AGG-ID: OdIyKrlsPcmBR6PMPO3nbA_1779375946
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-69d4e84695dso7466765eaf.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779375946; x=1779980746; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Q3t9Yeuq6DxysLkqSMiJKmEcJ7HmX7zk0pzvucmdbk=;
 b=jl2gMMUbGGCpCcRI1bQJWzaZYXsABzpWdBvEI6e+SDxAAd82t5vBpD4/uC3bzNWAbB
 cG/D5yx5tkgWGnnz9jGcIBFwwHv4iou5ODm9H+TC7fuXLHQV7iTEQGPxvLUrcKR+SSwD
 dpSJ+Ap4qhPmojF8mDakGrv/yXWZDJQJpyNXXSdAY/ONvEDpZZJ5zUVbY+a3plzapYfz
 JaweRqgmDKLEfoGmJSbUc7jDH7qz57VWkwXKHyd9lbDb+AHpGNvvifKNiiauWcRUOkFb
 bheDrd1p6a3q1H5b9LjZxpKBq6GcQE8/SitJskxea7SCuuElinnx69wvYh7V8n26LBVG
 by4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375946; x=1779980746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Q3t9Yeuq6DxysLkqSMiJKmEcJ7HmX7zk0pzvucmdbk=;
 b=fLQkPY4XealNtcjM7xwaRpLVB6vunC8Rl9E0bVkcK8cNzXMSzIzCb9ZjsuGOmD0Eqv
 gbn3IQIKZE1RVAsrH5oGeJBJEr/splhHgcr/wqZPN83r98U3TlkWnnyloxHBaR80UBv2
 zko0EcdUjK50almjd4HmmNFJyXGs1+/SslJ+FW4asWBzJAkELz2DQJYRHWozjBHAgL2c
 Totf26T2shYSzxNrETLhWM0NA6CEFs2ktekUqHp2vHd6u1WUEJFjoh896I4gy3NgfYqI
 kkmkFIf2MA9uSNOXHm1fMIz63voOUTtF8IF+ZFc89+e/7ZOSZtGxlhHYriHb72AmcGw8
 qDzw==
X-Gm-Message-State: AOJu0Yyg8HBCRtLaAqVyBaVj4nTL5oVbs+ovXtTVoeOb0y/COOxNHh/z
 mEpcUjd9jcbKJK4/MJMaPkPmVaLCDP4NcpNRMrmHMGSND79GS9Y1c7SAfVQrgPIqgAROKtG6v8b
 PzYiDvFz/X+sUE0lZWm3aj2AHfm67mHE7ej5+rINkMY5mLUJyz2PS2AaH
X-Gm-Gg: Acq92OG6DMxr4NG84tqZezzHJpSuMxxtz5A8XoAA+qgDhehyfg08DiQz/D3UVRRVEPl
 ogCQMY6BGgBNDwLMsBVI5x/ymIpnEjeJMIL0rofdnyK4Fng2eqy0pCfRsFWmnMhJ3ultctvxjuu
 Va97C5GWDhOMAdyRc30/ytB33Qoh5X+g9XrwWfkLlsRIl1BOoAskhL1Ex9jdVa+uejEnQiaH9l5
 ClxZSMZD/IZu/1DgWkfssaow8NdsMbaakstVG9urG31FxFKvOgv443tlICgcLNXhn/ZVp+/3nux
 XdvgTzKarOY8p5Qx13SfohMqN4N6Jss4134Hpm8yMfpmJkJF0QAfLPmSa/IACvA0gzgvC4k0ft6
 3M2D9U6GtuPaGVsSh1DsOekAJwSEMU0EdKnGyctiM0J9eOD0=
X-Received: by 2002:a05:6820:f033:b0:69b:902d:d347 with SMTP id
 006d021491bc7-69d6ee84475mr1477144eaf.27.1779375946146; 
 Thu, 21 May 2026 08:05:46 -0700 (PDT)
X-Received: by 2002:a05:6820:f033:b0:69b:902d:d347 with SMTP id
 006d021491bc7-69d6ee84475mr1477096eaf.27.1779375945660; 
 Thu, 21 May 2026 08:05:45 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc768d4ca8sm7150756d6.17.2026.05.21.08.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:05:44 -0700 (PDT)
Date: Thu, 21 May 2026 11:05:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 14/14] migration: Enable new switchover-ack
Message-ID: <ag8fRzWkcLg9-brO@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-15-avihaih@nvidia.com>
 <agzD1-wZ4MeKwgPT@x1.local>
 <66e26fcf-caef-4b30-aff2-6474f19013c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66e26fcf-caef-4b30-aff2-6474f19013c8@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 05:00:44PM +0300, Avihai Horon wrote:
> 
> On 5/19/2026 11:11 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 05, 2026 at 11:14:23AM +0300, Avihai Horon wrote:
> > > Now that VFIO has implemented new switchover-ack, enable it.
> > > 
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > ---
> > >   migration/options.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/migration/options.c b/migration/options.c
> > > index 44327c588f..91571f9d30 100644
> > > --- a/migration/options.c
> > > +++ b/migration/options.c
> > > @@ -108,9 +108,8 @@ const Property migration_properties[] = {
> > >                        preempt_pre_7_2, false),
> > >       DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
> > >                        multifd_clean_tls_termination, true),
> > > -    /* Use legacy until VFIO implements new switchover-ack */
> > Removing this line is fine because it's a very temporary thing.  But maybe
> > it would be good we have some rich documentation on both the legacy and new
> > behavior of switchover-ack.  Normally it would be qapi/migration.json, but
> > in this case the user shouldn't need to choose, so I think when keeping
> > qapi doc simple we need to have somewhere internal that document all these.
> 
> Sure, I can do that.
> Would adding it as a comment above struct
> MigrationState->switchover_ack_legacy be fine?

Sounds good!

-- 
Peter Xu


