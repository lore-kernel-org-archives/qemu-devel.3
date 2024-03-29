Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841FFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 11:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqA86-0001ED-Us; Fri, 29 Mar 2024 07:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqA85-0001E3-DJ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqA83-0006x2-EZ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711710633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjSrGug/i6Z0xyu+j+DDEk1OHI/DkvUqjk3OxtiP0Fs=;
 b=Zed07CP7lpXspl0CanzWDSe4pkFHM1hK5hBr2abriqTVZPVfSAIBTRuL/y/Cj7vNNVi0bq
 iy3R9Ph6QXvMbZFZEHZtyRmYOj8TbhcRjLcCmWLJbCUwrz6qypNWdWy6gYafdgK2wXeYZW
 4f8li2hPyJmBFH3wunImR98l9Kvpx2U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-SSHguPhxO-2yTP9geBQPbg-1; Fri, 29 Mar 2024 07:10:31 -0400
X-MC-Unique: SSHguPhxO-2yTP9geBQPbg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed2f873b4so977145f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 04:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711710629; x=1712315429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjSrGug/i6Z0xyu+j+DDEk1OHI/DkvUqjk3OxtiP0Fs=;
 b=nlo10WFMyxZTp96/Oi4Dw+pJr5J1qFdzk6GuMPmKAMD8l+9SSIZEJAhEevS5uCDXxH
 saLsW+vP6GtHqo+kdDu7tuay006/KUKIiMHX++jbW72OZKjl20vVmak0yMwNGsrQchV9
 i9BNgLrGptW1lC+x8Rmja8b4qfPbMrr0voer8MyBxGGcivz0XpLVPfbBeYs2Y/82fRi2
 w+BdiJ0qBnSUHoItPfsBxy68ZyJPJPKU0Hhp/joTTUrg+v0h8q+9PESs77S0eI3feLqV
 1K1Wyvcn8dH51omZzd/NN2tt/qN78f8v4uJ07tb22kwPNKeCCHzY0hK18j6+IJmcPfKq
 A/2A==
X-Gm-Message-State: AOJu0YzcrMdCD7M77f5Wvoc6kT7Vna7vtaAtn7gVg03x8Wi+tTIX7DkQ
 LkEu3laPnzDufq63iv9mM4kgiuRskWOWZ8JI8f3atHsNx4pUQ7FTlGsncy4XhDdkA9ZeHDDo0T7
 snxdQFnehuv+jSvRQLhJIAP2jFqcoAWxd5rDMRAwvsln77TDxwMROeZpO0R6kfryyrg5+CEug8A
 gh8GHFQLliI75rAi8bipxz5fNBzanJUOeYvabGzw==
X-Received: by 2002:a5d:4e11:0:b0:33c:e396:b035 with SMTP id
 p17-20020a5d4e11000000b0033ce396b035mr1192411wrt.69.1711710629374; 
 Fri, 29 Mar 2024 04:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcLIk2jbbrXTWBThhm6tt9bGSPyx4+SzYYqc0nTBoI2b0r9nfqUrFxUIkJA0ubW9ZDT5C7cLNcKcs5XPe/h3c=
X-Received: by 2002:a5d:4e11:0:b0:33c:e396:b035 with SMTP id
 p17-20020a5d4e11000000b0033ce396b035mr1192393wrt.69.1711710628983; Fri, 29
 Mar 2024 04:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
 <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
In-Reply-To: <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Mar 2024 12:10:17 +0100
Message-ID: <CABgObfb8EP+LZV8jF7sumQd2-hR1WTN-MCmcrK-NO0rGJu3b4g@mail.gmail.com>
Subject: Re: [RFC] util/error-report: Add "error: " prefix for error-level
 report
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 29, 2024 at 10:37=E2=80=AFAM <no-reply@patchew.org> wrote:
> > This was done in the context of inheriting the original error_report()
> > interface without the prefix style. And it was also useful to have a
> > means of error handling, such as exit(), when error occurs, so that the
> > error message - the most serious level - can be noticed by the user.
> >
> > Nowadays, however, error_report() and its variants have a tendency to b=
e
> > "abused": it is used a lot just for the sake of logging something more
> > noticeable than the "warn" or "info" level, in the absence of
> > appropriate error handling logic.

Unfortunately, this is the reason why you _cannot_ do what this patch does.

For example:

  error_reportf_err(local_err, "Disconnect client, due to: ");
  error_report("terminating on signal %d", shutdown_signal);

This should not be prepending "error" - it's not an error.

  error_report_once("%s: detected read error on DMAR slpte "

This is a guest error, so "error:" is probably not a good idea (it
should use qemu_log_mask).

And so on. :(

Paolo

> > But, in the use case above, due to the lack of a prefix, it is in fact
> > less informative to the user than warn_report()/info_report() (with
> > "warn:" or "info: " prfix), which does not match its highest level.
> >
> > Therefore, add "error: " prefix for error-level report.
> >
> > [1]: https://lore.kernel.org/qemu-devel/87r2xuay5h.fsf@dusky.pond.sub.o=
rg/#t
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   util/error-report.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/util/error-report.c b/util/error-report.c
> > index 6e44a5573217..e981c0b032f0 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -213,6 +213,7 @@ static void vreport(report_type type, const char *f=
mt, va_list ap)
> >
> >       switch (type) {
> >       case REPORT_TYPE_ERROR:
> > +        error_printf("error: ");
> >           break;
> >       case REPORT_TYPE_WARNING:
> >           error_printf("warning: ");
>
> Sounds like a good idea to me, but I think you should then also remove
> the hard-coded "error:" strings in the various error_reports():
>
> $ grep -ri 'error_report.*"error:'
> migration/block-dirty-bitmap.c:        error_report("Error: block device =
name is not set");
> migration/block-dirty-bitmap.c:                error_report("Error: Unkno=
wn bitmap alias '%s' on node "
> migration/block-dirty-bitmap.c:                error_report("Error: unkno=
wn dirty bitmap "
> migration/block-dirty-bitmap.c:        error_report("Error: block device =
name is not set");
> target/i386/kvm/kvm.c:        error_report("error: failed to set MSR 0x%"=
 PRIx32 " to 0x%" PRIx64,
> target/i386/kvm/kvm.c:        error_report("error: failed to get MSR 0x%"=
 PRIx32,
> util/vhost-user-server.c:        error_report("Error: too big message req=
uest: %d, "
> accel/hvf/hvf-all.c:        error_report("Error: HV_ERROR");
> accel/hvf/hvf-all.c:        error_report("Error: HV_BUSY");
> accel/hvf/hvf-all.c:        error_report("Error: HV_BAD_ARGUMENT");
> accel/hvf/hvf-all.c:        error_report("Error: HV_NO_RESOURCES");
> accel/hvf/hvf-all.c:        error_report("Error: HV_NO_DEVICE");
> accel/hvf/hvf-all.c:        error_report("Error: HV_UNSUPPORTED");
> accel/hvf/hvf-all.c:        error_report("Error: HV_DENIED");
> monitor/hmp-cmds.c:        error_reportf_err(err, "Error: ");
> hw/arm/xlnx-zcu102.c:        error_report("ERROR: RAM size 0x%" PRIx64 " =
above max supported of "
> hw/block/dataplane/xen-block.c:        error_report("error: unknown opera=
tion (%d)", request->req.operation);
> hw/block/dataplane/xen-block.c:        error_report("error: write req for=
 ro device");
> hw/block/dataplane/xen-block.c:            error_report("error: nr_segmen=
ts too big");
> hw/block/dataplane/xen-block.c:            error_report("error: first > l=
ast sector");
> hw/block/dataplane/xen-block.c:            error_report("error: page cros=
sing");
> hw/block/dataplane/xen-block.c:        error_report("error: access beyond=
 end of file");
> hw/rdma/rdma_backend.c:            rdma_error_report("Error: Not a MAD re=
quest, skipping");
> hw/s390x/s390-skeys.c:        error_report("Error: Setting storage keys f=
or pages with unallocated "
> hw/s390x/s390-skeys.c:        error_report("Error: Getting storage keys f=
or pages with unallocated "
> hw/usb/bus.c:        error_report("Error: no usb bus to attach usbdevice =
%s, "
> gdbstub/gdbstub.c:            error_report("Error: Bad gdb register numbe=
ring for '%s', "
>
>   Thomas
>


