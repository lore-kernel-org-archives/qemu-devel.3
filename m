Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080E8C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgx6-0001z1-5X; Tue, 18 Jun 2024 18:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgx4-0001ym-Q2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJgx3-0002HA-BC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718748315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMvIOYzPkVwpqcJA0MhGMbpGeGHqs/LPmuHKVZYPvvI=;
 b=DQz99CEdzJkGRKeBbMChz+VjbP4wdSaC3EBeRG+d8pw9HhSrmuAJX0BXQBSkPFGo8gVvw+
 fdjq7PDpNWBgjFxKwS9l0W4uCu+/x6yBJIRUE1qHnSH/eoWGmpJHrwSsh8/nWv9oARM1Ei
 xP8uHUnYQIcha0rm8GK5sbYhNOCQucU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Cxy0sVwaMoSo8Ip1gqi_yg-1; Tue, 18 Jun 2024 18:05:14 -0400
X-MC-Unique: Cxy0sVwaMoSo8Ip1gqi_yg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36250205842so117426f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718748313; x=1719353113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMvIOYzPkVwpqcJA0MhGMbpGeGHqs/LPmuHKVZYPvvI=;
 b=GpRwnA68v+9yVFZKt7tKF7cWAnbuNTdvqXJPhhhRjlqJuOsD+iWp9Xuey/tR9GdLuh
 wWmWTGRD7JTYOkB84LLirMgiLk7cyM9fyNMtWVgGuBUuj/d58qMLFNkhhV/SQ6/b6wTB
 5fa7+g8UDDMtW4kCbfWvGs/OCsC/3Sjactyf1ZaOQ8ch0NzEB6Pl8cVdJKSJbYj+5uAJ
 zC4x49MJYCxOVzQ6j+T3I0i7XS2PKA4/e5jxu6rSS3pRewi650YrHyhMZ0bjznQ2ywHY
 aTN/jj4mnMvariDj5rt/b+FeiH6SUylDISSEW94WZ02i9+Jps09cM4DOx4Ox+QFQjw+1
 3aTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF+nRqLN4sWpJL4rfxr2u/zXIUSugkauBgu2JiES/j9y4eR86dePc3MeH04fo4ncze0b3cfH6aIeHzRedjHBcVHO+6kqo=
X-Gm-Message-State: AOJu0Ywb8e2oTAWXmgGWB/6/IfXsE8QQkv9WybyNIL7VAR8WggeTsLc4
 KUqQ8JKJkYB1FYlDOInncqdDWuU1m9K7EZZbGYDZtd3gR5fbBWIOBvSDlfEMbTbFMjYeYsZbRmf
 s8259Vr244zCcgpkDV+568clPJp08mI840wQPvFi4EggkypH+q4z4
X-Received: by 2002:adf:f4d1:0:b0:362:1d6c:b867 with SMTP id
 ffacd0b85a97d-3621d6cb9c6mr3340029f8f.3.1718748312920; 
 Tue, 18 Jun 2024 15:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VuRTgU7FVN1ad89gKjsMPhkt3NL96dqbk140sU2gRsrz/La524wcMBa8vPQ+YxN7/ubIHA==
X-Received: by 2002:adf:f4d1:0:b0:362:1d6c:b867 with SMTP id
 ffacd0b85a97d-3621d6cb9c6mr3339980f8f.3.1718748311931; 
 Tue, 18 Jun 2024 15:05:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607510340fsm15251557f8f.93.2024.06.18.15.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 15:05:10 -0700 (PDT)
Date: Tue, 18 Jun 2024 18:05:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <20240618180459-mutt-send-email-mst@kernel.org>
References: <20240618211110.922809-1-nicolinc@nvidia.com>
 <20240618171311-mutt-send-email-mst@kernel.org>
 <ZnH53Qaqp5+Xo1jo@Asurada-Nvidia>
 <20240618173233-mutt-send-email-mst@kernel.org>
 <ZnIBbeITxG4ZRVVm@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnIBbeITxG4ZRVVm@Asurada-Nvidia>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 18, 2024 at 02:51:41PM -0700, Nicolin Chen wrote:
> On Tue, Jun 18, 2024 at 05:34:21PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jun 18, 2024 at 02:19:25PM -0700, Nicolin Chen wrote:
> > > On Tue, Jun 18, 2024 at 05:14:32PM -0400, Michael S. Tsirkin wrote:
> > > > > @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > > > >          }
> > > > >
> > > > >          /* Append the last RC -> ITS ID mapping */
> > > > > -        if (next_range.input_base < 0xFFFF) {
> > > > > -            next_range.id_count = 0xFFFF - next_range.input_base;
> > > > > +        if (next_range.input_base < 0x10000) {
> > > > > +            next_range.id_count = 0x10000 - next_range.input_base;
> > > > >              g_array_append_val(its_idmaps, next_range);
> > > > >          }
> > > >
> > > > A change of logic here - I think the new one is right and old
> > > > one was wrong, actually. Right?
> > >
> > > Sorry, I don't quite follow that question...
> > >
> > > Doesn't a patch correct an old wrong one to a new right one?
> > >
> > > Thanks
> > > Nicolin
> > 
> > 
> > So if base is 0xFFFF what should happen? I think previously we
> > skipped an entry and that is wrong. So that's another latent
> > bug this patch fixes then?
> > Worth documenting in the commit log too.
> 
> I had noticed that -- yes, ideally it should have been "<= 0xFFFF".
> Yet, practically input_base can never be 0xFFFF as it's calculated:
> 
> hw/arm/virt-acpi-build.c:245:                .input_base = min_bus << 8,
> hw/arm/virt-acpi-build.c:305:            next_range.input_base = idmap->input_base + idmap->id_count;
> 
> The first one always sets input_base to 0xXX00 (min_bus = 0xXX).
> The second one, as we know for id_count, must be 0xZZ00 too since
> input_base from the first place must be 0xXX00 and 0xYY00
> hw/arm/virt-acpi-build.c:301:                next_range.id_count = idmap->input_base - next_range.input_base;
> 
> So, it's a case that could never be triggered? Probably not worth
> highlighting IMOH...
> 
> Thanks
> Nicolin

Makes sense.



