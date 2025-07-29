Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449FEC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeij-0003rO-8m; Tue, 29 Jul 2025 03:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugeiX-0003gs-AS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugeiU-0005o0-Go
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753773941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ah1jSD7614FR6lH0p5YnurfvJNonZrWBdPaSlma29L0=;
 b=eufJ4JGgKHNBgToxRaBBTmRVdutVAvyYLPKQiaq8WE5vg0nB//mamx64Dc9StiDK+l0YEK
 XwwOk2Nm/FpftdJgcgUB7vtFU7anSjFtjfPqA1ZfnOxp/1mFQxMPr9mvqGzeQpVldUtAXw
 iBukCDrKd7xQ9KxTMxHRxGs5lUgPyHg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-1IpAyEzAM1eMSROTHBmlUw-1; Tue, 29 Jul 2025 03:25:39 -0400
X-MC-Unique: 1IpAyEzAM1eMSROTHBmlUw-1
X-Mimecast-MFC-AGG-ID: 1IpAyEzAM1eMSROTHBmlUw_1753773938
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235dd77d11fso55552715ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753773938; x=1754378738;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ah1jSD7614FR6lH0p5YnurfvJNonZrWBdPaSlma29L0=;
 b=dHXx8zqBGGx/28eaps018lqbfjZpxPXivVkL8pwcZDWN0K2I2aNiacaQMIAodFoi4o
 ltNNYUhn++jVJ5eKQuNxR7mtza8ZFkEpZl1TpI/z+GNTuAIIOb31Rtt2RlRwV9PcTJwg
 0sSt23C8/NIYpNFNqH2vLBeKF5X93bSQ23Ry10mOKxPnhQRa1jNFgeeQjXHDCfhTlrnt
 X9WVT6LSKHMcG7ZEA1cy79xCa/U05yERV0uR/ygRnOy73odN3PWeRRkkZguRMdVK79Jk
 JqwHcXO6rmWtmOvMjx1DL5X7yr801g2Pz+PnT4OZQne+/0AP1lDobskUefZpqeXnXrSq
 p6tg==
X-Gm-Message-State: AOJu0YzjSE8QS3g+61y/gcMDvgoVyonBY9UlPL6yBWaX2b0VXol2jb2y
 WgbjPkBXGb0o4bfoVZpxy7Vl2VEJSWM8q3FlmI2hxOR8gqVocNn1DfK4BHpIf1Icgtn9pByN76V
 FIc28cCyfJ60ibGnIfQQm08yw1Es29TOusPhVNi2BnT5wouhy+2ei9YBF
X-Gm-Gg: ASbGncvuwnHYriWwV4IiV44/T8PNnEf2sQiknwx8VAYw8toOURIX7uJ5PJiT6ZaKdWo
 YoHFeeJuM5Tor+v9kqtYVbAf0QtBUEN1NTM9xMBUaZ2gPjmIEZcRhpG8135/3C4+6Kjf+4tc89a
 iNm03/5eJf2mkUZWXl2z23RIi0CmoXLHRkPWWKcXVsNdCEJWDuWpa2n8aGsLhOFApZfEE/iIad4
 rKds0yNRv9lrrfZT8g4oK+EXBdR14Tt7EONy3aQnA/hT1IhiyLh194Lq8QJciNVVsLylpgHKUbT
 gXHeunBpHuGMHXdoyh8+skBf6P94XGMyC8x8Mqmp6GGGLLw7ous=
X-Received: by 2002:a17:902:d501:b0:23d:e2fc:6fe5 with SMTP id
 d9443c01a7336-23fb312a3ebmr235716695ad.49.1753773938331; 
 Tue, 29 Jul 2025 00:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWl3f6bdKSqD/D3auMB7WsrF7+5xfqmVmGBICSrEw+yycjuGaGvVD+z1sw+qjGnARtl+qyVQ==
X-Received: by 2002:a17:902:d501:b0:23d:e2fc:6fe5 with SMTP id
 d9443c01a7336-23fb312a3ebmr235716495ad.49.1753773937993; 
 Tue, 29 Jul 2025 00:25:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.71])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24032525257sm35083565ad.174.2025.07.29.00.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 00:25:37 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:55:23 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v7 08/24] migration: make loadvm_postcopy_handle_resume()
 void
Message-ID: <aIh3Y4ipgMh-UoDa@armenon-kvm.bengluru.csb>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-8-d52704443975@redhat.com>
 <CAMxuvazur4y2svycNvEYe35nH1CSOvLR7EJAm_tADssacTM_SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazur4y2svycNvEYe35nH1CSOvLR7EJAm_tADssacTM_SA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Marc-André,
Thanks for the review.

On Mon, Jul 28, 2025 at 02:25:26PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 25, 2025 at 4:20 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > d8f5f1966fda831899596173f20fbef25d78829d..ad96da3651b89023e4b70ffeecab46d176bae6f5
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2334,12 +2334,12 @@ static void
> > migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
> >      }
> >  }
> >
> > -static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> > +static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >  {
> >      if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > -        error_report("%s: illegal resume received", __func__);
> > +        warn_report("%s: illegal resume received", __func__);
> >
> 
> Could you add a comment to the commit message to explain why this somewhat
> unrelated change? thanks
Sure, will do.
> 
> 
> >          /* Don't fail the load, only for this. */
> > -        return 0;
> > +        return;
> >      }
> >
> >      /*
> > @@ -2391,8 +2391,6 @@ static int
> > loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >          /* Kick the fast ram load thread too */
> >          qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
> >      }
> > -
> > -    return 0;
> >  }
> >
> >  /**
> > @@ -2627,7 +2625,8 @@ static int loadvm_process_command(QEMUFile *f)
> >          return loadvm_postcopy_ram_handle_discard(mis, len);
> >
> >      case MIG_CMD_POSTCOPY_RESUME:
> > -        return loadvm_postcopy_handle_resume(mis);
> > +        loadvm_postcopy_handle_resume(mis);
> > +        return 0;
> >
> >      case MIG_CMD_RECV_BITMAP:
> >          return loadvm_handle_recv_bitmap(mis, len);
> >
> > --
> > 2.50.0
> >
> >
Regards,
Arun


