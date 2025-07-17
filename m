Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804EEC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucHnC-0005LD-Ol; Thu, 17 Jul 2025 02:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ucHmV-0004e7-TB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ucHmP-0005KG-P2
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752732459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skqi7wPAiRj7kfBT8DjZ2V+9K7zrN1h4fm/8KLYmCkk=;
 b=S7hi96YfmFrvvNFYwH0P6hT0j8xau+Roq+oF3hZGqR2xPkdWRC4eAE8rTSRaJHBb5SrVaL
 dB/JsGDN0Su3Pf2fr/46YgfLYHa6M4oycsGy3qbEvICWrXu1GqYB7SlJnNleILF1t8Hskt
 uMFxzCdA/tKgdY+nUHlPN+GKi/fzcrU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-WkXvr6swO62uKzDR151ZLQ-1; Thu, 17 Jul 2025 02:07:38 -0400
X-MC-Unique: WkXvr6swO62uKzDR151ZLQ-1
X-Mimecast-MFC-AGG-ID: WkXvr6swO62uKzDR151ZLQ_1752732457
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so249167f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752732457; x=1753337257;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skqi7wPAiRj7kfBT8DjZ2V+9K7zrN1h4fm/8KLYmCkk=;
 b=A1iRDjxCsUOyZU0ZBZ4fRS0Iz3RFuqyLnTxi2Dv5PhuenBXWLXnBXvELmGZ8eCL/yy
 4lOoByre+cWNj0ukEDk5sjsJAQOgOg6nsqzDXVo7OAZMbVCzINj4E2yfl4jlYBVUGX6a
 ntzWH0LDpNVAWQCIb2quL3DnOJUlQNQ8fKb0ZohkEkUgOUTnslsGmFzqRiIE0XcrzBaT
 bH281TT5wkPr/OZcqPVzIntzA2E7HFrlYEyYGDZtR2BgJam0ni38jt70UwqTWf+fBGr6
 V8+4rHBOZAlWehD3i5zxQ/DVWZrizS2nuFuAR9oY9PxEuCrESTKAgacBKYexo9Iet4nE
 u2ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSKTs8AHp4VXO+O1Det9r0nsrg2G45VqLtECA/62B1Ftm4QXxySEJm0c7kNTbq0APw5UO6y+ZYqmaV@nongnu.org
X-Gm-Message-State: AOJu0YwfnTVEh7IJWWedZuHTsQsfnUchmBlkRZw7A7cbWDOG1N8F4O2q
 yNas5mQDQWjU5+45R0mDQg7lc/jJbmdVN439OQZfr4JKvdaOnDIIy+VbxTfFqHomldGSmIkZIdO
 HOZYphB+JpRol4zm8cMupcLn25fL4he3F3ExunTzielnV+LeVPgZY/B/L
X-Gm-Gg: ASbGncs5kGmx89JiZ6PfkWmAkPKGMzIkipsOwRznv1yZqx+sGlYYKt6Nku0FTbkvCRB
 k/5ANke4tK9Lgdi71aj0Z7cngwGM207JHtd5JqlLA7l7hA9AvMpIIzCzsbLfoNkPhMFp7IXo3g5
 Dp84duEew/e5kVl8XgtdBc8oHBi+m5GjqBngBRpp1cnLmLwtX/OjYEjHoOddIPVgUr4UQiyFPWP
 9gT55lyGqCuP5o1y8GfDkN0okp5cM9c2TENYdB94e+UJzzX2SEAe2b+YGART0lHhLK73DADfhsb
 773bALUMTz5UahDzuAG36J9O9DQ0Q4NG
X-Received: by 2002:a05:6000:43cc:20b0:3a5:39be:c926 with SMTP id
 ffacd0b85a97d-3b60dd7aab1mr3283084f8f.32.1752732456579; 
 Wed, 16 Jul 2025 23:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMdUc3oyv5VmSQRDfa8MQYkKDHoKIRUi4pmn+9ogoMwp8PFwkBdoZ3UzF5jJmqP4TBhX43Yg==
X-Received: by 2002:a05:6000:43cc:20b0:3a5:39be:c926 with SMTP id
 ffacd0b85a97d-3b60dd7aab1mr3283059f8f.32.1752732456107; 
 Wed, 16 Jul 2025 23:07:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8cfsm19348959f8f.80.2025.07.16.23.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:07:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, eduardo@habkost.net,
 richard.henderson@linaro.org, alejandro.j.jimenez@oracle.com,
 Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
Message-ID: <20250717020716-mutt-send-email-mst@kernel.org>
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
 <20250716092916-mutt-send-email-mst@kernel.org>
 <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jul 17, 2025 at 11:17:05AM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 7/16/2025 6:59 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
> > > 
> > > 
> > > On 7/16/2025 6:07 PM, Philippe Mathieu-Daudé wrote:
> > > > On 16/7/25 09:31, Sairaj Kodilkar wrote:
> > > > > This series provides few cleanups and fixes for the amd iommu
> > > > > 
> > > > > The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and
> > > > > Alejandro's
> > > > > DMA remapping series [1].
> > > > 
> > > > 56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.
> > > > 
> > > > What is the point of posting obsolete code?
> > > > 
> > > > I'm not going to review further.
> > > 
> > > Hey Philippe,
> > > 
> > > sorry. I missed to add it in cover letter. Intention is to get feedback
> > > on this series. Since this is on top of Alejandro's series, I will
> > > rebase it once his series gets merged.
> > > 
> > > Regards
> > > Sairaj
> > 
> > Merged now, go ahead and rebase.
> > 
> 
> Hey Michael,
> 
> Sorry, I should have mentioned which series I am talking about,
> https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-\
> alejandro.j.jimenez@oracle.com/


Alejandro said he will send v3 of this.

> I know Alejandro's cleanup series has merged. I was waiting for
> DMA remapping series. But what I'll do now, is remove the patches that
> depend on his series and rebase remaining patches on top of master.
> 
> Thanks and sorry for inconvenience. Will take care of this in future
> 
> Thanks
> Sairaj
> 
> > > > 
> > > > Regards,
> > > > 
> > > > Phil.
> > > > 
> > > > > [1] https://lore.kernel.org/all/20250502021605.1795985-1-
> > > > > alejandro.j.jimenez@oracle.com/
> > > > > 
> > > > > The series is uploaded on github:
> > > > > https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
> > > > > 
> > > > > Sairaj Kodilkar (7):
> > > > >     hw/i386/amd_iommu: Fix MMIO register write tracing
> > > > >     hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
> > > > >     hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
> > > > >     hw/i386/amd_iommu: Support MMIO writes to the status register
> > > > >     hw/i386/amd_iommu: Fix event log generation
> > > > >     hw/i386/amd_iommu: Fix handling device on buses != 0
> > > > >     hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
> > > > > 
> > > > >    hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
> > > > >    hw/i386/amd_iommu.h |   9 +-
> > > > >    2 files changed, 146 insertions(+), 80 deletions(-)
> > > > > 
> > > > 
> > 


