Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05526606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RPq9LgUL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUfV-0008Nc-VZ; Thu, 29 Oct 2026 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMUfT-0008NP-R5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:16:03 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMUfQ-0007Td-R0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:16:03 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36a1947498bso65359eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793297759; cv=none;
 d=google.com; s=arc-20260327;
 b=Qi/KWKQ9ghDWMcfG3GPqpAsWHStq5bVxQyvH/MQP93CO6pm/32MGe5rogK+nu4cIU7
 4knUpkohEwFlcBRjHvzJ7cnQ9EnOTD3zBfYy5cp/1tMglYjvfvfB273+nC5OBX9t3uri
 6zKIR2nmRCN52FECyY5pI2L5JZJURg8AGRxsvXaOmXv22GvfkqWzlObV1T3cj+8RIdmk
 YzUt8BG1ePySXWcN0Ggz7nDo1nyIyICKv57YW/909gXSC2s5+4CfYHD3jhkNRCgiTeZG
 nZZfX0mNzPUFlsr0CvOWMpAXymcnZqiScKLo35kRKGxqOfVu5wiE+haNKRFb+IJnOoOC
 AElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1JRxrWhhe+x3E6Oo381RVLmBNosBeokT/6fZO2XGa+g=;
 fh=lZLkOphK9EAX+1MVdeTF4LY6MVAmJaj+PuynQ7+aa/I=;
 b=CPhKsBjtuiKyR7fu+CDUve8sH6MNa4bc9oQg6fat+Y8FejsWRazHJeX4QVurG/k0KL
 SRlz0b08KEScg3MXGfi+EwBJLiSsrxDI3Y/N9YL0TcTZsLEUSjP/TkwB3AYLwc76nFFJ
 aPcoMafc0veRqyn1rizpUXFKULit+Oa7WkY5MT1rnQukhUThWwWumhjKSaQ2Ey/9gZpe
 dYOnESiVOyBqsi5Nhn4VqfSfs3ufFiS/mTXCtSbZoo3gwuef1XQcg98ryGZKwKjKs6s5
 mpck1lg3GSuQnqsEPI7hhBxZ6U8se4/gj6eZxUCDP+agAOltAVyw/bbz5U/O8PwSSRLu
 F2ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793297759; x=1793902559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1JRxrWhhe+x3E6Oo381RVLmBNosBeokT/6fZO2XGa+g=;
 b=RPq9LgULeneTXN9HkX0Dvaw5sKRyv5oHaOd7J2s/cvfwmA3e8Ij8OXnKPn8WxJYnDm
 jyss9Awp+CFoVRjNmm5R0v4bBPgcI1bhPYcUj+/BRonpyD76r431dEcUAb0WwULnEtG8
 ujlQVViJXpYS4tC2OOLFT2/wiGEvMCXeJ+rd8+dl3usscOgHwCFpCXcZHEzA6MHmteeX
 1yvZf3S7R6+zuqltrplV0mjSSGMvT7U1ElpyT2RpsWEGKbKg+hX/AA7IEZc/MXdqOZOx
 3loUGSof78FJ2zYFTu50jQpdw66t0jE5RaFC5qsPHNE34/l8h9nGV2CP81wskRPOkMtH
 Xd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793297759; x=1793902559;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JRxrWhhe+x3E6Oo381RVLmBNosBeokT/6fZO2XGa+g=;
 b=QYUH8Uu9AEWL6nMJy8PBOF1voUVl4NMQ7FdUO/O9iNwcTmP8Q4g+Y0SzPl+yz41nsO
 QisPEFMXPhQc8aKKDUNgFXkuupFmBR5QrH+8T+AxTe2a9dXMtJWOu+MF6ZPB59LgUL82
 pHrMmOWc+QlxJp4ipZPQ21xbPF83FcPPzsDm2AXT+mXlswBLcsyP6x2zJTHPkmXeZnKh
 utXd+wB0HE1GwWtmu3qWOQaPh2TlGqqvwHIAC3ljFlMS9XGpbeL1VWkOXs8mlvtC8673
 Z5VxLvZF/bNw7kUvK8498MhvgV5aysllCgFLOP7vKiudqPvofbkW6EbAQWoENT5W1gd8
 /WxQ==
X-Gm-Message-State: AFq9FYKe2yewMsFm/z60aBX3RQsFcKzd/eRpDuYUc0s0fScuwSDs24cK
 z7kryMUU9o0EJFKT2mZlvvJwl5nkLeSNl2wI1ibilWyIXjau/Km9XerOogdnFGGDHhCcnSYjvpq
 ldr1qmmd5CGcIJ/3ySNnQ1ChaDQN3pvQ=
X-Gm-Gg: AYBFou1zJHatFiQWBRHduRvYzDyohlDZnYAPa36xGmr0j0oc8RDJKNO4hR+MhEdeMKk
 dJ8IGlrVjvTHRSFpqFsusVd54lp+lSvXTGOiBrFoJO12bYSmh2Wp98DANr7UrZx8dQfvtegmpGh
 yMApEfOgghV0RhhaIfu2ybwQTR8Gp1Pqcu1lp42CSdaVIp0icMwAoyBIpKPU98Rlb1oHukntkY/
 g77+6a6l7HND6tPf9BHJ6git69T4sNyvhKzWBo56haqpfu9tK4x92E+uC5GkSOFWySxKwpVzxPh
 ELV+EsFcQCBHUb/8o/Thksf1knjRKShnJ5TZV4Yj7u92KcSvwpZ1La39687YpZL9xBaZQcMoCWD
 R+PKn9ITyPLUo0u2gITP+/wkDmnW8XwHJg+glZIlJA1IEtkDATIG/ZkD1zxbsEK2HL0cI
X-Received: by 2002:a05:693c:88ce:20b0:36a:1f8:a5a4 with SMTP id
 5a478bee46e88-36a4241f808mr226212eec.38.1793297758883; Thu, 29 Oct 2026
 11:15:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
 <atDHwThz_5XPY9Yx@redhat.com>
 <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
 <auODPFwxQ0Bc0oi-@redhat.com>
In-Reply-To: <auODPFwxQ0Bc0oi-@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Oct 2026 22:15:46 +0400
X-Gm-Features: AclHuK_l8rBpnslYZKlOCbbURBK0KNiwuRF1yXWHeF0XpYo0khBSpujpQGowDyQ
Message-ID: <CAJ+F1CJJEX8TDQLS9okRNYQ2RU64YBnWOAqTG3K9PGnCjS8_Yg@mail.gmail.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 29, 2026 at 9:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Oct 16, 2026 at 11:20:11AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Oct 15, 2026 at 4:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat.com=
 wrote:
> > > > > This series introduces a new facility called 'tldr' which is a
> > > > > live data recorder. This is intended to aid support of production
> > > > > QEMU deployments, by providing a data collection facility that
> > > > > can be left "always on", such that in the event of a QEMU crash
> > > > > or guest OS crash, certain important information will be recorded=
.
> > > > >
> > > > > The data recorder has to be enabled by adding a "tldr-config"
> > > > > object instance with -object / object_add.
> > > > >
> > > > > With this series, the data recorder collects
> > > > >
> > > > >  * error_report/warn_report/error_printf messages
> > > > >  * QMP events
> > > >
> > > > It should probably be recorded at emission, not per monitor
> > >
> > > Opps.
> > >
> > > > >  * QMP errors
> > > > >  * QMP commands, which are not query-XXX/qom-list,
> > > > >    or any command associated with a QMP error.
> > > > >  * qemu_log output
> > > > >
> > > > > The last item is intended primarily to be used in combination
> > > > > with tracing and its 'log' backend, to have continuous
> > > > > recording of certain interesting probes.
> > > > >
> > > > > Each type of data is collected in a distinct circular
> > > > > buffer, such that high volumes of one type of data, does
> > > > > not result in overwriting other types of low volume data.
> > > > >
> > > > > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > > > > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> > > >
> > > > Instead of allocating and dumping by a signal handler, why not use =
a file-backed
> > > > mmap or a memfd? We would need to define a small fixed header for t=
he file
> > > > layout/buckets.  This would avoid all the issues with signal handle=
rs.
> > >
> > > That would impose a continuous I/O workload on data recording, which
> > > is something I wanted to explicitly avoid, until the time the data is
> >
> > Yes, a file-backed mapping shouldn't be the default, but memfd/tmpfs
> > should have the same performance.
> >
> > > needed to be preserved. This only persists the final data, not any
> > > intermediate data that is overwritten as the circular buffer wraps.
> >
> > Same design, the reader would handle the ring data
> >
> > > Coupling the in-memory layout to the on-disk layout also means that
> > > dumps would always be the max size, since we would not have grow-on
> > > demand buffers.
> >
> > The dump output would not be the raw data, a reader would emit the
> > same text format, skipping the unused parts.
>
> IMHO that reader has to be QEMU owned code, as otherwise we're
> exposing a private data structure to a 3rd party and that makes
> it public ABI/API which is highly undesirable for this.

The resulting data will be ABI/API anyway, no?

>
> > mapping reserves address space only, pages are allocated on first write=
.
> >
> > The benefits:
> > - no signal handler, no conflict with MCE, ASAN etc
>
> A signal handler is integral to some extent, as captured info about
> the signal is itself is an important part of the data record. IOW,
> even if moving writing of the dump out of the signal handler in some
> manner, I still want to be able to capture several siginfo_t fields.
>
> You can get that info from a core dump, but the working premise
> is that a core dump is not guaranteed available, whereas the data
> record dumps are something we can more easily acquire.

right.. this is something you don't touch in the cover letter. I
assume most systems have a core dump handler already (perhaps
differently on Windows), thus we could also rely on the dumped data
instead of a signal handler. We should be explicit about why we don't
follow that path

systemd/coredumpctl does store siginfo_t of the process too

>
> > - data survives SIGKILL, OOM, or a crash in the dump path itself
>
> Simplifying the signal handler to just stash the siginfo_t would
> help.
>
> > - data can be read from a hung QEMU
>
> Data can always be read from a hung QEMU by sending it a signal.
> We could wire up a non-fatal signal for this purpose if we want
> to read hung QEMUs without killing them.
>
> > Someone needs to hold the memfd to outlive QEMU, otherwise QEMU could
> > create a file under a runtime dir on tmpfs
>
> I wonder if QEMU could simply fork a child process itself that just
> hangs around waiting for death, and has a shared memory region with
> the main QEMU.
>
> We already have a '-run-with async-teardown' comamnd line, which
> forks a child process and uses prctl(PR_SET_PDEATHSIG) to get
> notified with the parent goes away.  We could expand that child
> process to also handle crash dump writing.

Yes, that should work, although I would like to have a rationale
why/when core dump aren't good enough.

thanks

