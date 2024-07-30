Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36413C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 21:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYuT0-000328-0p; Tue, 30 Jul 2024 17:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYuSz-00031f-7I
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYuSw-0006KT-Mt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722375179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJtI8N/n+/x1Q/3tK86+4wrW54PMPMdW8CL23Bw0nNA=;
 b=TPPl35NFTo9ePuyedt6Gj46ARxojg0BTVmNzOcDtPdGG6qPqnnPOllydewDLtdkpe5yRB8
 pM9rRW28LQZRanOBrDWf/HrG/m+uGkW/x9yIBG6ERFM4fca5/wUo0+CxD8p/PJNgbjKqHw
 qQ04wBtLrBDlGqdDGY9S8es1afyL9O8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-0yrU5kI5NQGiIZbfpjNwmg-1; Tue, 30 Jul 2024 17:32:58 -0400
X-MC-Unique: 0yrU5kI5NQGiIZbfpjNwmg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef244cdd30so52561191fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722375176; x=1722979976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJtI8N/n+/x1Q/3tK86+4wrW54PMPMdW8CL23Bw0nNA=;
 b=wIErLLPttW5pQ5adb1quDlvKxzmELjniQRUskZtSb9ejrv6Hf4xczDXEgxiRl8YMJQ
 jIksWon4RUeeYsRhQOabCDDyUgS/ZcJcJvegLdyBNJa+Vm6CC2RFRFB/mLsZJlpDZ3e3
 iBz5ba3kCk9Aj4bEReKB5q8kgknxYo1fxrcljK5AfdLo1zxlLbjMDyo+Gp28EmCiM58R
 zkRqUtl1DJM4j1fanwEIAV8g/Nbwz1RoadZhkWdylCGQjTb9QJsyrE9CnbWRQJohdnkJ
 ih/dUwmLhJNRi9wez+XrZX3fr7+JZRRsjzsCM7ghhD7HN2u5ZBZIGBcyFLDA4xKRrGuJ
 BmvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyK5/6sEMQda5bBH6qw69Pjvs0e67y9nuj/G4wr9NHJkZpm5dvOLiJHwLtyjlZO96B5GQ3JkzRuzImfvqV9pKSBTuWnM=
X-Gm-Message-State: AOJu0YwTD7EwrFAkigyAxcaepti2GRviqCEs0akUam38OApf3tEUBoAp
 C7ZzBHS0mm4hZvO2+a22w6geSrAZBhbF3lTOV04grNBOgFNJAFAuD6L93kk4XebpLMTBplNOU9R
 z1ZHbRq6jI/b8QJuw1bS63+nYJe+BBGcR5pYwiIANu9ISU4gklycj
X-Received: by 2002:a05:6512:36cd:b0:52e:9a91:bba3 with SMTP id
 2adb3069b0e04-5309b2707bbmr7002918e87.15.1722375176697; 
 Tue, 30 Jul 2024 14:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdjVyYBZJQiwFlh7JRqAY0LHjAjZU7dwIlT3mVwTUUklk1zA8Qbb8QCmTlgTvu54hRpT3qtg==
X-Received: by 2002:a05:6512:36cd:b0:52e:9a91:bba3 with SMTP id
 2adb3069b0e04-5309b2707bbmr7002901e87.15.1722375175990; 
 Tue, 30 Jul 2024 14:32:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:d5c3:625c:d5f0:e5f4:6579])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb68c2sm689687966b.190.2024.07.30.14.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 14:32:55 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:32:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240730172148-mutt-send-email-mst@kernel.org>
References: <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqlHKaQXzKGcnoBM@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> > This is not what we did historically. Why should we start now?
> 
> It's a matter of whether we still want migration to randomly fail, like
> what this patch does.
> 
> Or any better suggestions?  I'm definitely open to that.
> 
> Thanks,
> 
> -- 
> Peter Xu

Randomly is an overstatement. You need to switch between kernels
where this feature differs. We did it with a ton of features
in the past, donnu why we single out USO now.

Basically downstreams just don't separately add kernel features vs
qemu features. There's little reason for them to do so.



-- 
MST


