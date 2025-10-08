Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE37CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XX2-0006pA-6h; Wed, 08 Oct 2025 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6XX0-0006ob-6y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6XWr-0005Hd-N0
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759942835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtA238vBjbS5w4eztX9894nZPwQu2lRqnYC28Jctx18=;
 b=UhutLzqIRPG+xeGf7vz5bhv5QyBvi6Bujnm872BjkaeqetSqRvqtKGpxVN/YSHTIRF2D7/
 A0mSqkFnmYOL1zqoQD6zCy0SWSiyR6VfGTi9zeKD5vdI7qy2Bi6ntwZFrnHMZH+TpASjbJ
 DoWqFZVBIJrF6idKTzWu2UezkN+mlB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ga9O-xmPOtewXnLCEsc9YQ-1; Wed, 08 Oct 2025 13:00:28 -0400
X-MC-Unique: ga9O-xmPOtewXnLCEsc9YQ-1
X-Mimecast-MFC-AGG-ID: ga9O-xmPOtewXnLCEsc9YQ_1759942827
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so422406f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942827; x=1760547627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtA238vBjbS5w4eztX9894nZPwQu2lRqnYC28Jctx18=;
 b=UlYhDu1huBTjTZFDdTqkiokLEUbZGC3topr1bCV4ODGB92vr9kqevFxgbvFWaO2D4o
 8VSmi7TSy/9gOIJzB53ZaE6DA+l0bVFN1ohmMl0ozSnLLVsokAbjs0xdGwojZbhAb9wi
 zgRDKW7oKj9qxXqRuWVmssRmmxGLrZbro9Cveoja6hPQOuLdbe1i5snvLPanUkRcLTht
 KGTnmRlIexZHNVhMj4EOqLSFuPYpJBUZ1IRwKJQmMVk4TOTSTXBsE+Hb6bOPteabtCsQ
 iaop07G18EUWh0vPxXJkq3lTdrdrACFIu2O/gOmQVGSxhf3FcnKDKD0JUs+mau8ShECa
 QEDQ==
X-Gm-Message-State: AOJu0YwxGPz+pHgIyUDO8nJoUuhUCje0qVeWfgzCXxdUimhUzUuPYfo3
 UOJ48Rwh46iNxaBNjvLdLwQkfrvzTatv41UhvRgnIDAPR160IwUghAaL0qzXZI8898fwJSGS7UL
 Bup3w0nJ2fv5meyqe4A50N9aBuxK0GU6KtZU5SIVN6WnIVfQnjHPX5ihGpH/ZTpleNkgSo7WTI5
 gQ16V6EDoQpeZ1fc72JVMneKG+jPkvD54=
X-Gm-Gg: ASbGnctE967QtduVbtB96+o8iDD9fx8rY4hGpMZBmqbdGgZlgafzQeEZMgLdWqfCgKQ
 tR5ADQopR4EDyIQ72rHmQH+KC2VFPTjGXgmzdrwnTwVLNftirkpU7aLoHdTzukkiuQHXAxxcdla
 xZLihEobVofHLGygklI3ksswCVZSP9sD48pgMkZToL372EFU1+fFai1o9IwAxJkxUZ4VGDcukWo
 UfzRyrKDUdciJucU7pAotrjeXI1qw==
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id
 ffacd0b85a97d-42667177c79mr2784699f8f.16.1759942826802; 
 Wed, 08 Oct 2025 10:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc9rglzMjURsHR7z536QlHx7+7BLyLN4ItXyvFTCiajDb9cMsSjitkEqChtSHFr8+5mj8VPejrHtQd1RTqeYU=
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id
 ffacd0b85a97d-42667177c79mr2784678f8f.16.1759942826407; Wed, 08 Oct 2025
 10:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251008152701.411964-1-pbonzini@redhat.com>
 <aOaOWbrE443LpqPX@redhat.com>
In-Reply-To: <aOaOWbrE443LpqPX@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Oct 2025 19:00:13 +0200
X-Gm-Features: AS18NWCP70opTSdmE3Amsd-TCpWwF2fQ9KjOwttzWOBEzjMYWd5FWVVplSvW79Q
Message-ID: <CABgObfZctSC6=uNXY0qjMa2AKdX4tGTQYoXQbgFaskPDg1rQVQ@mail.gmail.com>
Subject: Re: [PATCH] qobject: make refcount atomic
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 8, 2025 at 6:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> > C code will
> > have to agree with not making changes to the QObjects after they've
> > been passed to Rust code.
>
> I wonder whether that latter constraint on the C code will hold
> true in practice ? Particularly thinking about scenarios where
> we add/remove link properties to QObject's, potentially at any
> time during life of QEMU via QMP/HMP commands ?

Those are QOM objects, not QObjects (the QMP/JSON data model) which
are what this patch affects.

C "things" that are not thread-safe are protected by
"assert!(bql::is_locked!())", either written explicitly or hidden
behind BqlCell/BqlRefCell.

In this case, the safety is covered by QObject::from_raw being unsafe.
Whoever calls it needs to know that the C code is not going to mutate
the QObject until the Rust side is done with it.

> With this unref method being void, how does the Rust code
> know when a QObject is no longer alive after it has called
> unref ? Does it need to know this to provide any safety
> guarantees ?

No, the safety guarantees can come from knowledge of what the C code will d=
o.

In particular, the safety is covered by QObject::from_raw being
unsafe. Whoever calls it needs to know that the C code is not going to
mutate the QObject until the Rust side is done with it. This for
example is true of arguments to QMP commands, which are the main case
where C could pass QObjects directly to Rust.

Something like

void qmp_marshal_query_stats(QDict *args, QObject **ret, Error **errp)

would become

fn qmp_marshal_query_stats(args: *mut QDict,
    retp: *mut *mut QObject, errp: *mut *mut Error)
{
    let qobj =3D unsafe { QObject::cloned_from_raw(args.cast()) };
    let result =3D from_qobject::<StatsFilter>(qobj)
         .map_err(Into::into)
         .and_then(qmp_query_stats);
    match result {
        Ok(ret) =3D> {
            let ret_qobj =3D to_qobject::<Vec<StatsResult>>(ret);
            unsafe { *retp =3D ret_qobj.into_raw(); }
        },
        Err(e) =3D> unsafe { e.propagate(errp) },
    }
}

(and even discounting the lack of tracing, that's quite a bit smaller
than the C code thanks to all the automatic consumption of args and
ret when passed respectively to qmp_query_stats and to_qobject, just
by virtue of how those functions are declared).

Paolo


