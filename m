Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F2DCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVCAw-0002Oq-Th; Thu, 04 Jun 2026 13:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCAv-0002Oh-8E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 13:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCAt-00051S-4b
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 13:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780595289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GN1z0fbM14jQIM5G9QT0DiVW2hcPqdwIyTpoY6iNhm4=;
 b=iR2Sb+eVqQtmk5SAr37U53gDJ1amQLEhY/YhEBOFEAz2FRZtMdufYXSo7JBTS1T7x/xY60
 fww94VDcSemQa9L1PeyE9tdF5gcOV7WXjABMSD3sFm8ecnSEV9sUGnN6G0mRmEEar1NF0T
 nfIZnR4j1csaSBTP1caA1ZF1yAAgoqE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-InlsYhEdPOig5OgR-zkIBw-1; Thu, 04 Jun 2026 13:48:07 -0400
X-MC-Unique: InlsYhEdPOig5OgR-zkIBw-1
X-Mimecast-MFC-AGG-ID: InlsYhEdPOig5OgR-zkIBw_1780595287
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157de5360fso476299185a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780595287; x=1781200087; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GN1z0fbM14jQIM5G9QT0DiVW2hcPqdwIyTpoY6iNhm4=;
 b=JbVd36/dSN2HRxc2LMMC/CslWuaupxm89WtLIyqE5/ey5tTiUfVZKEKhyAwoOYYSeb
 TNMbtJpN8qMjFTh/x2xyoURd4gvrg5W0wsy3cqxBl2bHVFYMimuABunApfR1niTuq/jn
 2zv6D22kQ6/j9OLxeADAXx01QsbO639UNuyxFYUwFMzrtsDdDcpjTiMmW4247yIyxBqf
 b/xhEZbyp9Dj1EEEIFwfdY8LZhHIxuSMM22TWNNwKy94d/2i8YKbWFTyhX2Gigit0bur
 WM9EBSkPcpXIBG5kGQnTZO5Zw6RD5/S9x0Kv3ptjO8z53fviSvPXuegYZWRuUuG2/urs
 xkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780595287; x=1781200087;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GN1z0fbM14jQIM5G9QT0DiVW2hcPqdwIyTpoY6iNhm4=;
 b=Fp9tpih6EcTWXBRI8fX9yftpjZ+4mFvvHicb1yXgtZ6VdCRt66bh0LqVxXqoKSJhjX
 38ov2bEl9OjH/6HKKgFskHWk8dHKmsPHiNNojmTcBW1a6RXpZhi0F2whjXdw6mNT7OlR
 stLBE1F69fzU0Tuj78uWuXY9Q1UZD7KPrfaoEi2gwnaJv4GggIw1+Qg7OScZdFT0wK2J
 L+kIR3bvJThbQ4WKuWIgPeDp1YzV7eXzcibFTB/5wTT/PDQrReggA72rPuHML9RWTGmB
 pO6Mw2GG7D5dw/e4MlbHGol8KBbo//YGBdM1iAD8vZK/EKlZm/qmcyN2+4onl1C4bCOT
 Csew==
X-Gm-Message-State: AOJu0YyyCRL9HAfKNzsVeB4CIkJJwFqTiiwBtdIIi3HiEf0kuorCpSAI
 v4dZh8mquZsfI0u5gbaZV0Ct1XZKyoyZqcRsnHIo5hv/TIltUVmZeedIn6p/29d00ILKT4/jHG+
 3pQr3+etxTVHLh6Qh5o0bytFrO7HjB+/ykR0Ec9iFBeEWno6e9j4iIYv6
X-Gm-Gg: Acq92OGs9oK3qtc2x6HCpaNHB3bacmJsJQEvhpjnSOLbAX3Mem9hIevYZbTzSwIXgDy
 KN0Wiou/tBFBFiOPgzZQAKMJeaek3NEasFTVN06VvhMIhhIdE76JaI6dNSHqQ7wUrACP+Vv64Tn
 cg6qOhhaAYAq4TzFKFcpoQy9dYzpHhSb6rZ1+fURDeVedcJyxfAS9At8ga1QmtfCR//pxc+84zG
 tNcQfS4eoGAOSHW+Y/2TbAYSDrWY+SCc/Xu1+LcXIuq1GUkMsua8H0heUEWfIDruUpDOX8mLGwo
 VYOIdiewxaItgDCPd07AULlAeWu3cHNhdBngpjaDJiN3PJOrnNLCtPw6wfK6JayvyVAehVSNGQW
 dPmyTjguqZJkY8xV+gQPL91SA3Q==
X-Received: by 2002:a05:620a:241b:10b0:90c:f935:490d with SMTP id
 af79cd13be357-9159afeb252mr495634485a.43.1780595287070; 
 Thu, 04 Jun 2026 10:48:07 -0700 (PDT)
X-Received: by 2002:a05:620a:241b:10b0:90c:f935:490d with SMTP id
 af79cd13be357-9159afeb252mr495629685a.43.1780595286494; 
 Thu, 04 Jun 2026 10:48:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00ba04sm632622485a.7.2026.06.04.10.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:48:05 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:48:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 07/13] migration: Fail migration if switchover-ack is
 requested after switchover decision
Message-ID: <aiG6VJ632WGwBwWC@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-8-avihaih@nvidia.com>
 <aiCRwvoVl_Z7J3bL@x1.local>
 <a4e5178d-2102-48e8-861c-232266f8da9e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4e5178d-2102-48e8-861c-232266f8da9e@nvidia.com>
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

On Thu, Jun 04, 2026 at 06:36:14PM +0300, Avihai Horon wrote:
> 
> On 6/3/2026 11:42 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jun 02, 2026 at 12:26:15PM +0300, Avihai Horon wrote:
> > > Switchover ACK is checked only during precopy while the guest is still
> > > running. The last migration_can_switchover() decision and guest stop are
> > > not atomic, so a device may want to request another switchover ACK in
> > > the gap after switchover decision has been made but before the guest is
> > > stopped. Migration would then miss that request, which can increase
> > > downtime.
> > > 
> > > Cover this case by failing the migration if a switchover-ack was
> > > requested during that time.
> > > 
> > > Ideally, precopy iterations should be resumed in this case, however,
> > > VFIO doesn't support going back to precopy after being stopped, so
> > > implementing such logic would require non-trivial changes to the guest
> > > start/stop flow. Given the above and that this case should be rare,
> > > failing the migration seems reasonable.
> > > 
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > One nit:
> > 
> > > ---
> > >   migration/migration.c | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 4bb649a467..6ee1c795ff 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2810,6 +2810,27 @@ static bool migration_switchover_prepare(MigrationState *s)
> > >       return s->state == MIGRATION_STATUS_DEVICE;
> > >   }
> > > 
> > > +static bool migration_switchover_check_switchover_ack_pending(MigrationState *s,
> > The name is slightly confusing.  It says "check if there is pending ack"
> > but then it returns true if there's no pending ACK..
> > 
> > Maybe migration_switchover_is_acknowledged()?
> 
> Sure, or maybe migration_have_new_switchover_ack_pending()?

Sure.

> 
> I just noticed that I overlooked one corner case:
> If guest is stopped during precopy and source has pending acks > 0 (e.g.,
> virsh migrate with --timeout param), then we will fail in this check and
> unnecessarily abort migration.
> 
> I thought about doing the change below. It's not as clean as I'd want it to
> be, but I have no other ideas.

Yes, it's not good to bleed switchover_ack_pending_num all over the
places.. Maybe you can make qemu_savevm_query_pending_final() return an
error when seeing any newly popped ack request while querying?  Then the
new function is not needed.

Thanks,

> 
> ===========8<===========
> diff --git a/migration/migration.c b/migration/migration.c
> index 6ee1c795ff..6054453b18 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2810,37 +2810,47 @@ static bool
> migration_switchover_prepare(MigrationState *s)
>      return s->state == MIGRATION_STATUS_DEVICE;
>  }
> 
> -static bool
> migration_switchover_check_switchover_ack_pending(MigrationState *s,
> - Error **errp)
> +static bool migration_have_new_switchover_ack_pending(
> +    MigrationState *s, uint32_t old_switchover_ack_pending_num, Error
> **errp)
>  {
>      uint32_t pending_num;
> 
>      if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
> -        return true;
> +        return false;
>      }
> 
>      pending_num = qatomic_read(&s->switchover_ack_pending_num);
> -    if (pending_num > 0) {
> +    if (pending_num > old_switchover_ack_pending_num) {
>          error_setg(errp,
>                     "Switchover ACK was requested by %" PRIu32
>                     " devices during switchover",
> -                   pending_num);
> -        return false;
> +                   pending_num - old_switchover_ack_pending_num);
> +        return true;
>      }
> 
> -    return true;
> +    return false;
>  }
> 
>  static bool migration_switchover_start(MigrationState *s, Error **errp)
>  {
>      ERRP_GUARD();
>      MigPendingData pending = {};
> +    uint32_t old_switchover_ack_pending_num;
> 
>      if (!migration_switchover_prepare(s)) {
>          error_setg(errp, "Switchover is interrupted");
>          return false;
>      }
> 
> +    /*
> +     * If the guest was stopped during precopy (e.g., by management), we
> may get
> +     * here with switchover_ack_pending_num > 0. Store the current
> +     * switchover_ack_pending_num value before the final pending query to
> +     * distinguish between existing pending ACKs and new ones.
> +     */
> +    old_switchover_ack_pending_num =
> +        qatomic_read(&s->switchover_ack_pending_num);
> +
>      qemu_savevm_query_pending_final(s, &pending);
> 
>      /*
> @@ -2848,7 +2858,8 @@ static bool migration_switchover_start(MigrationState
> *s, Error **errp)
>       * Fail the migration in this case since we currently don't support
> going
>       * back to precopy.
>       */
> -    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
> +    if (migration_have_new_switchover_ack_pending(
> +            s, old_switchover_ack_pending_num, errp)) {
>          return false;
>      }
> 
> ===========8<===========
> 
> Thanks.
> 
> > 
> > > +                                                              Error **errp)
> > > +{
> > > +    uint32_t pending_num;
> > > +
> > > +    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
> > > +        return true;
> > > +    }
> > > +
> > > +    pending_num = qatomic_read(&s->switchover_ack_pending_num);
> > > +    if (pending_num > 0) {
> > > +        error_setg(errp,
> > > +                   "Switchover ACK was requested by %" PRIu32
> > > +                   " devices during switchover",
> > > +                   pending_num);
> > > +        return false;
> > > +    }
> > > +
> > > +    return true;
> > > +}
> > > +
> > >   static bool migration_switchover_start(MigrationState *s, Error **errp)
> > >   {
> > >       ERRP_GUARD();
> > > @@ -2822,6 +2843,15 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
> > > 
> > >       qemu_savevm_query_pending_final(s, &pending);
> > > 
> > > +    /*
> > > +     * Switchover-ack requests done after switchover decision, are not allowed.
> > > +     * Fail the migration in this case since we currently don't support going
> > > +     * back to precopy.
> > > +     */
> > > +    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
> > > +        return false;
> > > +    }
> > > +
> > >       /* Inactivate disks except in COLO */
> > >       if (!migrate_colo()) {
> > >           /*
> > > --
> > > 2.40.1
> > > 
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


