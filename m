Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9205DD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSiX-0004AB-Hh; Mon, 26 Jan 2026 14:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSiV-00049x-GT
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSiS-000120-Lo
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769457458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4jYgYt/XBwBMQpOb06y7cLq3XcnBe2LJ+i8HY16uco=;
 b=KMtZN3N1/0iZW/l729SkZZPK79/737FB+80LGEq1hiJJWnCmxgxRKgDs4d3/8+4BjXuKuK
 6XuFmd8ddvlSKLoQRzsem9TghneIBjr+EX41rWqUUBeKbhuSBeCl90c8tUShwgeSmLIeY3
 V7I9gl1++bDfybIMbmiSeg8RLvTAf3I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-zqfzL2SnPcmxv8mZkNiOxg-1; Mon, 26 Jan 2026 14:57:37 -0500
X-MC-Unique: zqfzL2SnPcmxv8mZkNiOxg-1
X-Mimecast-MFC-AGG-ID: zqfzL2SnPcmxv8mZkNiOxg_1769457457
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso165718036d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769457457; x=1770062257; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l4jYgYt/XBwBMQpOb06y7cLq3XcnBe2LJ+i8HY16uco=;
 b=dA/5kCofo40NvDtYzUu5a1fEOosH9tKJIsVLeuuoDl0s1B5Z3vJKrAlN9r1L+qF4jl
 z/OIA9wnVoXKWVmaoU1XfcSCcy0ZkCyUzs1xJHvQuhREB8b/06JARvOg3gcn436gcyx8
 LyW6Eum4LAhF2fiv3PpvSgBDYpLKszl9zXk7X36zwBw37v5np1fNjlsiqWDfOlP1yzm2
 B+YsEbK9uG0RIQz9wWi7k1baM8BAveNI2CnGe8COPvmtWWEtFCDndNy9iZz2y0rhD6+a
 BLWVSQbbACeuuEvtrA9rF7Wevjog1b5K7M8he+ALYuSyDKjOhTqxMoMVovyCGN16B6u5
 PbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769457457; x=1770062257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4jYgYt/XBwBMQpOb06y7cLq3XcnBe2LJ+i8HY16uco=;
 b=dCeAW3k7OPEC9mChHjCRaivVNORY0CMa6qIIfW8m2/cTMeBSiV+DM1ZEELshopx6bm
 XqqzSEamuBhV/HkplNn+HHcTEV6uM13J1to2ivNzxLnjgiUbxpMEinqbbv73VDiMoxIv
 JvDQIm86KkOkHUxGlK9Cbpc1b9pvLtF0YdG6NuOPQeJdWN14t/zRT5KqKEt/xJWYrY4H
 FVCyHRmWINcNDQsOsq1ogqNFLedd9yodEqOsL3jbAw5JnwU/f/s9zXFITR4pZCE2kk9S
 s7OFaqEZDzcL/JHdXgcQUTRslvysMURWl+yhp+0fRQ1tCCxRIpmQPDbI25tOxZKKiCVu
 +1Kg==
X-Gm-Message-State: AOJu0Yy1s5U8LdBqpP8G2ZqtmP+l3qABgW3LWa5pq+lLh5AJy/1+y0dG
 JaDygKfTQ51mnuEl67srZcD+6oL2atuYRTid3KIbm31smFIDVYAbQZ/vSdtHqEul6Q2t0kohR2a
 9OS7Xyg7GPrnBJ0MQ7nEji9wPYzGrB5q/2ghIjahj6912FV4DNe3WYEuKggte3s11
X-Gm-Gg: AZuq6aJY11o47r16p35mP1P+XM1tyRm6P/iLXFvHU3ycnKvyl/OSQJyttyg8jc15s+k
 o921ITnlvzpzIFNZG9Ea18e85Ue1a8vof2bdT9s+B2IWFEhPXvy8/qnFLYIILA+h3RKaK/hh0hr
 SBRWEnwbjwanVMIKssvHeYiYo0mmU08jEotL7SWDKy3zzjcPgETFmIkcRpguKkklTX2xpW5im7M
 8x93pdeWNTJczOq3ndhn1RouPmpyEwrHkjBIqW4FU+JKfBDYWYSuVw0Crnx3pHzoOMZo44sg90I
 E3mXh7JrhxR5AGcBC44v38GTEDWQZNwDL3PHQ6wLjBzyK7FKQHW+sg+1QRTOzghBRE4j8TRb/7Q
 ND1Y=
X-Received: by 2002:ac8:7fc8:0:b0:501:4701:e9f9 with SMTP id
 d75a77b69052e-50314bb0320mr71946251cf.26.1769457456649; 
 Mon, 26 Jan 2026 11:57:36 -0800 (PST)
X-Received: by 2002:ac8:7fc8:0:b0:501:4701:e9f9 with SMTP id
 d75a77b69052e-50314bb0320mr71945971cf.26.1769457456122; 
 Mon, 26 Jan 2026 11:57:36 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9c7d3sm88871871cf.34.2026.01.26.11.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 11:57:35 -0800 (PST)
Date: Mon, 26 Jan 2026 14:57:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
Message-ID: <aXfHLrW3cq1CbVke@x1.local>
References: <20260122232456.12722-1-farosas@suse.de>
 <aXeV9fpBm_kKNi6t@x1.local> <87ecncgp6s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecncgp6s.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 26, 2026 at 04:16:11PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jan 22, 2026 at 08:24:56PM -0300, Fabiano Rosas wrote:
> >> Fix a couple of leaks detected by Coverity. Both are currently
> >> harmless because the visitor in the setter can never fail and the
> >> whole of the getter is unused, it's only purpose at the moment is to
> >> provide a complete implementation of the StrOrNull property.
> >> 
> >> Fixes: CID 1643919
> >> Fixes: CID 1643920
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
> >> ---
> >>  migration/options.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/migration/options.c b/migration/options.c
> >> index 9a5a39c886..9dc44a3736 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
> >>          str_or_null = g_new0(StrOrNull, 1);
> >>          str_or_null->type = QTYPE_QSTRING;
> >>          str_or_null->u.s = g_strdup("");
> >> +        *ptr = str_or_null;
> >
> > Yep, fixes the leak.
> >
> > However does it then mean a get() can internally update this Property?  It
> > used to be NULL, now it's QTYPE_STRING "".
> >
> > It may make slightly more sense to me to have zero side effect on a get()
> > call. Say, keeping *ptr==NULL after get() returns (as before), while we can
> > use a temp string ("") for the visitor.
> >
> > I randomly checked another get() provider, e.g. get_drive() does that.
> > Should we follow?
> >
> 
> Hmm, I'm actually inclined to assert. This is code for the very specific
> purpose of allowing compatibility of -global tls-* options which are
> properties of the s->parameters object.
> 
> The only way the property could be NULL in the getter is if the setter
> has failed. Is there a way we could make the setter fail without it
> being a programming error? I don't see it.
> 
> - the default for the property is an empty string.
> 
> - setting via set-parameters bypasses the qdev code entirely.
> 
> - device_add is not reachable because of dc->user_creatable = false.
> 
> - object_set_propv and qom_set use a string visitor, so no type mismatch
>   to trigger the qobject_to(QString, qobj) cast.

I agree, assert would even be better.  Then, maybe let's add a quick
comment for it?  Something like:

    /*
     * Assert for both str_or_null be present and not QNULL. 
     * Guaranteed because ...
     */
    assert(str_or_null && str_or_null->type != QTYPE_QNULL);

-- 
Peter Xu


