Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800AC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvoI-0003Fs-PP; Wed, 02 Jul 2025 07:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvoG-0003Cv-Cl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvoC-0006OE-Gm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751456359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbXD+fuhLYRUUQols/5l9LfDt9BnTJzkdryyDyIaqKY=;
 b=StaBMKE6782quPaqJimL4jEwukYFDzaqpndg8vTHeYizhZjo9gPSOvm8Vdj1nBYdU0CBST
 1Q8sUnqt7RItW1sfe059DVtBPeBHCn+2ykepca7w3OD6J1svtjSlLwk255qm4VeLeepTQv
 hzgolwZmgZRRaioyGEKQiOHBfH8WV2c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-E3IRaboCOaeMcRjLC8OtBQ-1; Wed, 02 Jul 2025 07:39:18 -0400
X-MC-Unique: E3IRaboCOaeMcRjLC8OtBQ-1
X-Mimecast-MFC-AGG-ID: E3IRaboCOaeMcRjLC8OtBQ_1751456357
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234906c5e29so55295645ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 04:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751456357; x=1752061157;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbXD+fuhLYRUUQols/5l9LfDt9BnTJzkdryyDyIaqKY=;
 b=mkD/hE4BNK5FIp6QXpMg/5kP36hG7wDqdGPup/egI1NKAtS/ew45Mk0l8KWq+hfVPs
 5xj4S8wKSKOxQxRIx2hWLk40Ya3qD4UpRYCEMW/efOlZVsKEwVxtHUbRT+Rvu92JlONr
 XxlKEgx9VuztekpWqnMtyIVYSmx5nItdscRMZ2wIKeFIVNAxr4nvYZMYw1sYbp+sNXat
 ampjiwNeFM5D07GTvsQ2diByonMZXXOT3oX9Qe4a0P2PgAEcbIUzKjHFcLoMHVSpeTXV
 /obXlk3rwMAUtOzekI4etmlRmY+Dswx8AEZ7+A2f/8ISkmD/qGk3hws3SeqBtTzJGzwc
 UU3w==
X-Gm-Message-State: AOJu0Yy+y0IHC5v90QUZ4aw9sBmsGPMIXmtXLuVwK69zY4mactPV6BBS
 lLUsN/uUCpLSiJSZEWpsLOzwChcsb+P165JmCrI9xx42RAyLs4Or47UniCJCXaHAWrj+i6T//AC
 k+BvC8FWgB0euvnBCpGq1u6djApXOKgSIyt3TPbMuZ0ZIUsh8dLx0v9We
X-Gm-Gg: ASbGncvyiMstaXWFyJYaOdww9yYD6DAHiTALWF/Hh/E8XPLZ5FoYECV/gOxx+e/KSMD
 dY5dwC1+H3A6vVIVfgCuSW0D9M3x7C0Dz0998/9Jho6bqjDz8IeQadtBWQeFIzvR9lTP3u4zhpP
 T/xjJSa8TyOWOYfFOQt0S9wuQiY+iB6NgwkndXUJEjqXA74Q7u2mjdj2baH/TKdy+1LlQXs6jBW
 HFSGAu+hZwNqGMCXYrTnZYpf56tDZw9B4UVxZZKccJbUclueOGdiNKXkeBxy/lyYUnUAq/WuMmU
 l6ozxkyjrKJqV0sdE+l/v/IY1rtdLlHJGZU=
X-Received: by 2002:a17:902:da86:b0:234:bfcb:5c1d with SMTP id
 d9443c01a7336-23c6e56f464mr34618775ad.40.1751456357176; 
 Wed, 02 Jul 2025 04:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiDFvHNsEQjxGIjEF5Nlfj7u38K97J6V8D1yzkhpBX5TKIETzwP/GMYGrR7A/7ydAdVXyaoQ==
X-Received: by 2002:a17:902:da86:b0:234:bfcb:5c1d with SMTP id
 d9443c01a7336-23c6e56f464mr34618345ad.40.1751456356709; 
 Wed, 02 Jul 2025 04:39:16 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3ad23csm124803355ad.145.2025.07.02.04.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:39:16 -0700 (PDT)
Date: Wed, 2 Jul 2025 17:09:06 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/3] backends/tpm: Propagate vTPM error on migration
 failure
Message-ID: <aGUaWg0pe0PhjIQe@armenon-kvm.bengluru.csb>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
 <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
 <CAJ+F1CLHo9BhcMkNL7Fv_EJ+kw-JQ0_Q3y-047uqsrCeTi31xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLHo9BhcMkNL7Fv_EJ+kw-JQ0_Q3y-047uqsrCeTi31xQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc-André,

Thank you for the review.

On Tue, Jul 01, 2025 at 04:21:23PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 24, 2025 at 4:26 PM Arun Menon <armenon@redhat.com> wrote:
> >
> > - Introduce a new post_load_with_error() hook that will
> >   take in the Error object as a parameter.
> 
> You should make this a different patch.

Agreed. Updated in version 3.

> I wonder if adding another
> callback is the right approach, as only one of the two is called. I
> would rather change the existing callback.

This was briefly discussed in the ticket comment section.
https://issues.redhat.com/browse/RHEL-82826
The idea is to gradually introduce convert the codebase to using
post_load_with_error() hook. Therefore, the call is kept in mutual
exclusion to post_load().

> 
> > - This error object is set if the loading of state fails.
> > - The error can then be retrieved using QMP command
> >   {"execute" : "query-migrate"}
> >
> > Buglink: https://issues.redhat.com/browse/RHEL-82826
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
> >  include/migration/vmstate.h |  1 +
> >  migration/vmstate.c         |  4 +++-
> >  3 files changed, 24 insertions(+), 20 deletions(-)
> >
> > diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> > index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928d160595b17be810 100644
> > --- a/backends/tpm/tpm_emulator.c
> > +++ b/backends/tpm/tpm_emulator.c
> > @@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
> >  static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
> >                                         uint32_t type,
> >                                         TPMSizedBuffer *tsb,
> > -                                       uint32_t flags)
> > +                                       uint32_t flags,
> > +                                       Error **errp)
> >  {
> >      ssize_t n;
> >      ptm_setstate pss;
> > @@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
> >      /* write the header only */
> >      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
> >                               offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
> > -        error_report("tpm-emulator: could not set state blob type %d : %s",
> > -                     type, strerror(errno));
> > +        error_setg(errp, "tpm-emulator: could not set state blob type %d : %s",
> > +                   type, strerror(errno));
> >          return -1;
> >      }
> >
> >      /* now the body */
> >      n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->size);
> >      if (n != tsb->size) {
> > -        error_report("tpm-emulator: Writing the stateblob (type %d) "
> > -                     "failed; could not write %u bytes, but only %zd",
> > -                     type, tsb->size, n);
> > +        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) "
> > +                   "failed; could not write %u bytes, but only %zd",
> > +                   type, tsb->size, n);
> >          return -1;
> >      }
> >
> > @@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
> >      n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
> >                               (uint8_t *)&pss, sizeof(pss.u.resp));
> >      if (n != sizeof(pss.u.resp)) {
> > -        error_report("tpm-emulator: Reading response from writing stateblob "
> > -                     "(type %d) failed; expected %zu bytes, got %zd", type,
> > -                     sizeof(pss.u.resp), n);
> > +        error_setg(errp, "tpm-emulator: Reading response from writing "
> > +                   "stateblob (type %d) failed; expected %zu bytes, "
> > +                   "got %zd", type, sizeof(pss.u.resp), n);
> >          return -1;
> >      }
> >
> >      tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
> >      if (tpm_result != 0) {
> > -        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
> > -                     "with a TPM error 0x%x %s", type, tpm_result,
> > -                     tpm_emulator_strerror(tpm_result));
> > +        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) "
> > +                   "failed with a TPM error 0x%x %s", type, tpm_result,
> > +                   tpm_emulator_strerror(tpm_result));
> >          return -1;
> >      }
> >
> > @@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
> >   *
> >   * Returns a negative errno code in case of error.
> >   */
> > -static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> > +static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
> >  {
> >      TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
> >      TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
> > @@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> >
> >      if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
> >                                      &state_blobs->permanent,
> > -                                    state_blobs->permanent_flags) < 0 ||
> > +                                    state_blobs->permanent_flags, errp) < 0 ||
> >          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
> >                                      &state_blobs->volatil,
> > -                                    state_blobs->volatil_flags) < 0 ||
> > +                                    state_blobs->volatil_flags, errp) < 0 ||
> >          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
> >                                      &state_blobs->savestate,
> > -                                    state_blobs->savestate_flags) < 0) {
> > +                                    state_blobs->savestate_flags, errp) < 0) {
> >          return -EIO;
> >      }
> >
> > @@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
> >   *
> >   * Returns negative errno codes in case of error.
> >   */
> > -static int tpm_emulator_post_load(void *opaque, int version_id)
> > +static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
> >  {
> >      TPMBackend *tb = opaque;
> >      int ret;
> >
> > -    ret = tpm_emulator_set_state_blobs(tb);
> > +    ret = tpm_emulator_set_state_blobs(tb, errp);
> >      if (ret < 0) {
> >          return ret;
> >      }
> > @@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
> >      .name = "tpm-emulator",
> >      .version_id = 0,
> >      .pre_save = tpm_emulator_pre_save,
> > -    .post_load = tpm_emulator_post_load,
> > +    .post_load_with_error = tpm_emulator_post_load,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
> >          VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -207,6 +207,7 @@ struct VMStateDescription {
> >      MigrationPriority priority;
> >      int (*pre_load)(void *opaque);
> >      int (*post_load)(void *opaque, int version_id);
> > +    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);
> >      int (*pre_save)(void *opaque);
> >      int (*post_save)(void *opaque);
> >      bool (*needed)(void *opaque);
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 3f8c3d3c1dcfe14d70bab1f43b827244eb4bb385..c5dfffd9bad7285e819d4769e055d47157caab34 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -232,7 +232,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >          qemu_file_set_error(f, ret);
> >          return ret;
> >      }
> > -    if (vmsd->post_load) {
> > +    if (vmsd->post_load_with_error) {
> > +        ret = vmsd->post_load_with_error(opaque, version_id, errp);
> > +    } else if (vmsd->post_load) {
> >          ret = vmsd->post_load(opaque, version_id);
> >      }
> >      trace_vmstate_load_state_end(vmsd->name, "end", ret);
> >
> > --
> > 2.49.0
> >
> >
> 
> 
> -- 
> Marc-André Lureau
> 


Regards,
Arun Menon


