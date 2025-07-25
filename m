Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B31C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCcg-0006gp-BS; Fri, 25 Jul 2025 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCcX-0006ZL-JK
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCcV-0004HU-KO
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rkLioDIF3QRMDbwOfmkM5eC+WXwdDO2ICHQ5uWC3XA=;
 b=B4YFIIykKxD+ypT6Bm6pR+7jZEED1TJYVN6bgmj3lb9gdOrdOAsp//Vhf+a+srZ2okDkMi
 I1gka+TMAJK35iTlhIlLSnZEdPE1qdKPW8wuhRK6tpnTKHSwl0run7qzsN+JD4AhPttxvl
 EgfSg21rl367fAjZco28TiWBQMafjfk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Dg05iZfTOFiLeuBtImQzmw-1; Fri, 25 Jul 2025 03:13:27 -0400
X-MC-Unique: Dg05iZfTOFiLeuBtImQzmw-1
X-Mimecast-MFC-AGG-ID: Dg05iZfTOFiLeuBtImQzmw_1753427606
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b39280167fdso1591427a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427606; x=1754032406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rkLioDIF3QRMDbwOfmkM5eC+WXwdDO2ICHQ5uWC3XA=;
 b=HQHgD3mY7Ak8VDa+z+gx5ijtUupXLrUA3JntnaBrMUTk/HjwqN8Qymst8m0AtOKRZT
 q0xVAyqHkXtr+AMLm0M9u7gH8EP4ScUWGHEMmn/iFhMZh3EH7M/CjRUXlWZTijZRXDpT
 t8AWBdiJHoJHdENF+M1Hrw6J0c6cevbL1fyJroB1/ShR/KLrwm7sCtTKijFhNkfjBkn3
 vINV5Czkm3cF1xeuN/wFERb2D6HT+O7dsV9B8TGzmSUEspYtqrdCtbW2U7WqtItOWR50
 3PmUKIXznM9AavkqAWG8aIMC5Fbt+VsKxnnqV2OHe0+WREbqzCtY/y0l6eFRc3q3MD4u
 a+VA==
X-Gm-Message-State: AOJu0YzsUf7ZXuAKscCoOEDkOM1GTiC3ZNFjPSSxNXxke4voJOqoSfTG
 1uEnJ2cOCNDTOVj6kVkupSrjfaWl2QZwBxlk1Tn1ND5Ty9aR+XUiD6Q8D/JevS6RRWfNoqqFJf2
 WMU29zYSQSprDgXQiEMfnA0rR3f+0e9WSFS3QMuMUMkiDI7lJ0L/YZuTo
X-Gm-Gg: ASbGncspdyoF3nrujGM5QaNQdw1Ymuq/c8vr7Q/5GBP/aAtrVInI1X3zKLkLWO5ew5U
 zTaGuLhag3fiuPL+yP914+fs+ElEp+OViOVRAEVCWPwVuLKhMw6gzDfbvAGxo8INU0yyjL5+JzM
 lq4FI2yeb/K2wXQ7VDsLMG1Hza/Bc0OhN9ZsGG5pTGgjMPxCgu9UIb8s4jM4ES3tnbiT+XkEdfe
 UjYbriL8hpSTSLxMFoCIkyq7/3vE303QZtLPUAz7Kjo6CLk/yo+tUoLdFP26c7Cr5MiGbO3BdW5
 GOybgZ6MUh47IlS6wsZamxwwSHttrMIhDTIVHrTuZGERvN40YkZ7
X-Received: by 2002:a05:6a20:958e:b0:238:3f54:78f4 with SMTP id
 adf61e73a8af0-23d7041081amr1212850637.46.1753427606091; 
 Fri, 25 Jul 2025 00:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExU0O2BF2VONPF5IfMo9qXkhOvzM+hCGSmwAk2JlELT4dB/H8ERc5s/TbGAb34LIdxcQQD0g==
X-Received: by 2002:a05:6a20:958e:b0:238:3f54:78f4 with SMTP id
 adf61e73a8af0-23d7041081amr1212780637.46.1753427605555; 
 Fri, 25 Jul 2025 00:13:25 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f6c115413sm2783768a12.49.2025.07.25.00.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:13:25 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:43:14 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 08/24] migration: push Error **errp into
 loadvm_process_command()
Message-ID: <aIMuin_eiJffxo58@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-8-fef740e15e17@redhat.com>
 <6966dd7b-635a-422c-b4ac-584c0c1fce49@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6966dd7b-635a-422c-b4ac-584c0c1fce49@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,
Thanks for the review.

On Mon, Jul 21, 2025 at 09:38:53PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_process_command() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/savevm.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 66 insertions(+), 21 deletions(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 96af7b412f2ed43468f4bcac8b833cda223f8321..d8feb9e1599d019636cd400ee7ebe594df27bd1d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2546,12 +2546,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
> >    * LOADVM_QUIT All good, but exit the loop
> >    * <0          Error
> >    */
> > -static int loadvm_process_command(QEMUFile *f)
> > +static int loadvm_process_command(QEMUFile *f, Error **errp)
> >   {
> >       MigrationIncomingState *mis = migration_incoming_get_current();
> >       uint16_t cmd;
> >       uint16_t len;
> >       uint32_t tmp32;
> > +    int ret;
> >       cmd = qemu_get_be16(f);
> >       len = qemu_get_be16(f);
> > @@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
> >       }
> >       if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
> > -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> > +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> >           return -EINVAL;
> >       }
> >       trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
> >       if (mig_cmd_args[cmd].len != -1 && mig_cmd_args[cmd].len != len) {
> > -        error_report("%s received with bad length - expecting %zu, got %d",
> > -                     mig_cmd_args[cmd].name,
> > -                     (size_t)mig_cmd_args[cmd].len, len);
> > +        error_setg(errp, "%s received with bad length - expecting %zu, got %d",
> > +                   mig_cmd_args[cmd].name,
> > +                   (size_t)mig_cmd_args[cmd].len, len);
> >           return -ERANGE;
> >       }
> > @@ -2590,11 +2591,10 @@ static int loadvm_process_command(QEMUFile *f)
> >            * been created.
> >            */
> >           if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
> > -            int ret = migrate_send_rp_switchover_ack(mis);
> > +            ret = migrate_send_rp_switchover_ack(mis);
> >               if (ret) {
> > -                error_report(
> > -                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
> > -                    strerror(-ret));
> > +                error_setg(errp, "Could not send switchover ack "
> > +                           "RP MSG, err %d (%s)", ret, strerror(-ret));
> >                   return ret;
> >               }
> >           }
> > @@ -2604,39 +2604,84 @@ static int loadvm_process_command(QEMUFile *f)
> >           tmp32 = qemu_get_be32(f);
> >           trace_loadvm_process_command_ping(tmp32);
> >           if (!mis->to_src_file) {
> > -            error_report("CMD_PING (0x%x) received with no return path",
> > -                         tmp32);
> > +            error_setg(errp, "CMD_PING (0x%x) received with no return path",
> > +                       tmp32);
> >               return -1;
> >           }
> >           migrate_send_rp_pong(mis, tmp32);
> >           break;
> >       case MIG_CMD_PACKAGED:
> > -        return loadvm_handle_cmd_packaged(mis);
> > +        ret = loadvm_handle_cmd_packaged(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> 
> This "return -1" is extraneous.
> 
> The error_setg() call is later replaced with "[PATCH v6 09/24] migration:
> push Error **errp into loadvm_handle_cmd_packaged()", but this "return -1"
> is simply removed in the patch. There is no need to add it in the first
> place.

Agreed. I will remove the return -1 here.

> 
> > +        }
> > +        return ret;
> >       case MIG_CMD_POSTCOPY_ADVISE:
> > -        return loadvm_postcopy_handle_advise(mis, len);
> > +        ret = loadvm_postcopy_handle_advise(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_POSTCOPY_LISTEN:
> > -        return loadvm_postcopy_handle_listen(mis);
> > +        ret = loadvm_postcopy_handle_listen(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_POSTCOPY_RUN:
> > -        return loadvm_postcopy_handle_run(mis);
> > +        ret = loadvm_postcopy_handle_run(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_POSTCOPY_RAM_DISCARD:
> > -        return loadvm_postcopy_ram_handle_discard(mis, len);
> > +        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_POSTCOPY_RESUME:
> > -        return loadvm_postcopy_handle_resume(mis);
> > +        ret = loadvm_postcopy_handle_resume(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_RECV_BITMAP:
> > -        return loadvm_handle_recv_bitmap(mis, len);
> > +        ret = loadvm_handle_recv_bitmap(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_ENABLE_COLO:
> > -        return loadvm_process_enable_colo(mis);
> > +        ret = loadvm_process_enable_colo(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       case MIG_CMD_SWITCHOVER_START:
> > -        return loadvm_postcopy_handle_switchover_start();
> > +        ret = loadvm_postcopy_handle_switchover_start();
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +            return -1;
> > +        }
> > +        return ret;
> >       }
> >       return 0;
> > @@ -3074,7 +3119,7 @@ retry:
> >               }
> >               break;
> >           case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f);
> > +            ret = loadvm_process_command(f, NULL);
> >               trace_qemu_loadvm_state_section_command(ret);
> >               if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                   goto out;
> > 
> 

Regards,
Arun


