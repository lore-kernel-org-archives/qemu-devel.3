Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55436C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSSIh-0001ix-GB; Tue, 23 Jan 2024 20:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rSSId-0001dy-Rl
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rSSIb-00060m-RU
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706060608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAs8PX+Eo6fGpjv1IpdoZekJnEyXvNDhvYWp4y0TMyo=;
 b=HHvd2f3z7bU/lfKNYeEg5+zm/NNed9tlGOaiUBZuP92vVGenfs31NaZ5YZZchvxdh/5KSo
 lgqIDSELIaV3p3IsHParBhPAMztG9lmVnjnaNKATDaZOFsCy4LG/jVDVVvbWL9B9gkamkX
 pOr9gssBjININ4vW/eqtMIvglpMo54Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-IlNeg4DmMIqlEL3ILpjBWA-1; Tue, 23 Jan 2024 20:43:27 -0500
X-MC-Unique: IlNeg4DmMIqlEL3ILpjBWA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so736412a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706060606; x=1706665406;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAs8PX+Eo6fGpjv1IpdoZekJnEyXvNDhvYWp4y0TMyo=;
 b=m8+MPiOJRL8CxQP1MZtmeQhkMr0kpuJODsdxr+n3uAJPPmj5m+LpcaOuUmHQ3jSinp
 FWhIH4h6IGwmf1crpS30eXJjVxsntMspwbJV0mm78kd4dIA4e2l/EwE6VpTX1EZRUsE9
 gSFZuORddkPksTSpbob3RRH3BSWmD2WN4ziusWB3QMEJHGlDR5UfBVcS56nBvyLtbhd1
 Wd5GsCqIYU6ome2Ft6fmsKfku28UMZS8OMWAiUQ5tM/0W2YhuSu5OD5S21OUAbI/0W6R
 YNHtRJiVta+rEFKD+TnhX5o+U7+XO5LFiDnNTdMZboWLJZ/ILnYgRvs02ocht9ZL+RXL
 thFQ==
X-Gm-Message-State: AOJu0YxtyJY3Njsi8Huk4e6qqNdfomTAbyGt9JNi99JqofYdALJtZrhB
 /Z0Q7chhfvJkjBsCWMGmoD2oATQZpspx5BHNdzuOrhvOXuglItw8KTjTlGxSiKkoSzrxLUZblGy
 gNh17uuX6kqpe4APzUvrYGMMn2ohlr7NDqXPX4bb5s7iq4YJmtCW1
X-Received: by 2002:a05:6a20:e68c:b0:19a:3d53:3ecf with SMTP id
 mz12-20020a056a20e68c00b0019a3d533ecfmr935746pzb.1.1706060606092; 
 Tue, 23 Jan 2024 17:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGZWNGLFqRpKFCTFx5d7xfOgzlI2n9/S6sxSnbKjwaSxg3mi/Q9FIdky0lbX+3qDTIonAM3g==
X-Received: by 2002:a05:6a20:e68c:b0:19a:3d53:3ecf with SMTP id
 mz12-20020a056a20e68c00b0019a3d533ecfmr935733pzb.1.1706060605760; 
 Tue, 23 Jan 2024 17:43:25 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jw12-20020a170903278c00b001d73047d4f9sm5947555plb.284.2024.01.23.17.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 17:43:25 -0800 (PST)
Date: Wed, 24 Jan 2024 09:43:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Het Gala <het.gala@nutanix.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org, farosas@suse.de,
 armbru@redhat.com
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Message-ID: <ZbBrN-V8goSJxEst@x1n>
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <Za93I-50U745B27C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za93I-50U745B27C@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 08:21:55AM +0000, Daniel P. Berrangé wrote:
> On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
> > 'uri' argument should be optional, as 'uri' and 'channels'
> > arguments are mutally exclusive in nature.
> > 
> > Fixes: 074dbce5fcce (migration: New migrate and
> > migrate-incoming argument 'channels')
> > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > ---
> >  qapi/migration.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index eb2f883513..197d3faa43 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1757,7 +1757,7 @@
> >  #
> >  ##
> >  { 'command': 'migrate',
> > -  'data': {'uri': 'str',
> > +  'data': {'*uri': 'str',
> >             '*channels': [ 'MigrationChannel' ],
> >             '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
> >             '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
> 
> Hmm, this mistake shows a lack of coverage in migration-test.c for
> the 'channels' argument. I thought the original series adding 'channels'
> included the tests for this. Either way, this needs to come with test
> coverage for use of 'channels', with 'uri' omitted.

Agreed.  Het, do you plan to provide a test case?

-- 
Peter Xu


