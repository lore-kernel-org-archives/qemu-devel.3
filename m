Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FC1CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6N8-0003qo-CN; Tue, 09 Sep 2025 17:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw6N3-0003qU-NT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw6Mt-00037q-3O
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757455146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BrMEu5w7A3WYBDryGciNc3sIJ0/fRr/tF+pcqGpzek=;
 b=Yu41SdHTjP+NjGIlfGWw3M8KmTkgQuJAUw0/C7XZPxrfO551tNzg5QXlmpHOTC7fXlhGZ/
 vWk75sPXvAwd6sADG674M9YYUxm1SClnCMIDbSTMQAgmP/fKRxJX9cOKTmwnxT2Gaf39ma
 tgFnHiKlcPtYw6jkOvbxFxsPWwHFc3I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-8RGkLZoYNg-PM-5uMiSd1g-1; Tue, 09 Sep 2025 17:59:04 -0400
X-MC-Unique: 8RGkLZoYNg-PM-5uMiSd1g-1
X-Mimecast-MFC-AGG-ID: 8RGkLZoYNg-PM-5uMiSd1g_1757455144
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b6019b13b2so153135851cf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 14:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455144; x=1758059944;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8BrMEu5w7A3WYBDryGciNc3sIJ0/fRr/tF+pcqGpzek=;
 b=BE43ZPa1otzPGaYsX54LTyBCqAbNSSz/NSu91VOvFBGfsNLpUcCmGzWX7iNIsFmeCJ
 EAK1x9ndfcgHeRdLLLxQ1PMX139dK6hf66y5XWkVE4f1pp49H37sYAb0hI23z497n74w
 atzBGEA71EotUtxCQVE2EYPj/ljXJpqYkqQUU9O47X0pFP449Od3mrn1GOKEVlBvExJi
 6ObosBlS4Fywr/iircw6DNigmlAG/objsvEnyS+3I4BUDzpalu5Bmktw/yybJchc0TlG
 98UNXbjNR1q6Ll9a5ITquDO69v9fAH3xyIQd0H0rJ/Vvq8dC47ktJFx5tPYdN7usQNJt
 TErQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvETtf7KFUN16Ol9RKt+2ZSvpRlFyU8pBrJn59UA+ES4qX+4m0SzYOe8sV6Ba45zQE7k9L3jrcfik0@nongnu.org
X-Gm-Message-State: AOJu0YwPdg6DVIl4Oz/GqYNGCMqWHQJOwttDjv559LMhhFjMeFy/U3PQ
 pN4cqgmz2rrYWEzlwxuQWC8jU5jUhn/pmoy5AJSpkrQ1DDSpcmxtdDhXsmdK/kKJnaJpUKa5DuK
 C43xdjDLzS8SbEfDRYwvJcsq6HtytbCFLp+6l2DfW4C1mtMk/F53FEO19
X-Gm-Gg: ASbGnctL6XDDX32w+oHEsf/8hVstsdyUWLXgRNcYXWAN9Qor5fIAZXJX38TEVoBzKvq
 RJ4AYPK7zF7yRAs8CzwwG+cIGKIuQZNeZ302LuKlOeKnmUkQJo1pg+2dFfTt1/lf8cMqJgS+eMU
 MurOWpCFK7M6y6zCCOds0prLvPbxxcQk5KohPSlkVny5226E8UCTudEJ9WeB7vdaVF4qe5gTIFa
 1YTdtQxh805NPBn9sm1p+QnNcitBhZdBOFc51GvfgTlyTK2T54/c6ik0eX8XGsJhHE649SBoqfw
 ppw7cjpX0/TwWBoDBKnNf+N/snfblQC+
X-Received: by 2002:ac8:594a:0:b0:4ab:7f61:4339 with SMTP id
 d75a77b69052e-4b5f83b411bmr147966161cf.31.1757455143684; 
 Tue, 09 Sep 2025 14:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUakMhjqtD5EbQhrtOVuF5pczupoNFdjJDfX0z8gaS/FZFAeIrFqDB62ws1ja5FREAOfCOCg==
X-Received: by 2002:ac8:594a:0:b0:4ab:7f61:4339 with SMTP id
 d75a77b69052e-4b5f83b411bmr147965931cf.31.1757455143056; 
 Tue, 09 Sep 2025 14:59:03 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61ba865f9sm14539241cf.12.2025.09.09.14.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 14:59:02 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:58:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMCjGVUiM3MY-RM3@x1.local>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMBDIwKDxTVrBJBQ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Usual system defaults for TCP keep-alive options are too long for
> > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > before it starts checking if the connection is not broken.
> > 
> > Now when InetSocketAddress supports keep-alive options [1], this patch
> > applies migration specific defaults if they are not supplied by the user
> > or the management software. With these defaults, a migration TCP stream
> > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > second interval before considering the connection as broken.
> > 
> > System defaults can be still used by explicitly setting these parameters
> > to 0.
> 
> IMHO this is not a good idea. This is a very short default, which
> may be fine for the scenario where your network conn is permanently
> dead, but it is going to cause undesirable failures when the network
> conn is only temporarily dead.
> 
> Optimizing defaults for temporary outages is much more preferrable
> as that maximises reliability of migration. In the case of permanent
> outages, it is already possible to tear down the connection without
> waiting for a keep-alive timeout, and liveliness checks can also be
> perform by the mgmt app at a higher level too. The TCP keepalives
> are just an eventual failsafe, and having those work on a long
> timeframe is OK.

For precopy it looks fine indeed, because migrate_cancel should always work
on src if src socket hanged, and even if dest QEMU socket hanged, it can
simply be killed if src QEMU can be gracefully cancelled and rolled back to
RUNNING, disregarding the socket status on dest QEMU.

For postcopy, we could still use migrate_pause to enforce src shutdown().
Initially I thought we have no way of doing that for dest QEMU, but I just
noticed two years ago I added that to dest QEMU for migrate_paused when
working on commit f8c543e808f20b..  So looks like that part is covered too,
so that if dest QEMU socket hanged we can also kick it out.

I'm not 100% sure though, on whether shutdown() would always be able to
successfully kick out the hanged socket while the keepalive is ticking.  Is
it guaranteed?

I also am not sure if that happens, whether libvirt would automatically do
that, or provide some way so the user can trigger that.  The goal IIUC here
is we shouldn't put user into a situation where the migration hanged but
without any way to either cancel or recover.  With the default values Juraj
provided here, it makes sure the hang won't happen more than a few minutes,
which sounds like a sane timeout value.

Thanks,

-- 
Peter Xu


