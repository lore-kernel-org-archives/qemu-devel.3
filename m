Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EDDE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXe95-000456-4n; Tue, 14 Jan 2025 05:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXe8x-0003tv-Qf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXe8w-0003Ba-6g
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736850448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52hrgni7t4Fn8Trrwho1Ps7RaGxj4Q0ZCrLW1+g7ROg=;
 b=N0TTqyAKC+BFY+MwunYl65rgcKdTJeI6fpKhGdLY3SXyl9ckGq1rwRPp8P05stH3IShl/2
 sRSwyIwwpu/joaYmieZ1sUxauuKTH6/HXia6yFr6jqw5Gw2gUn71YqfEAgRtbVKAnTIaoK
 uV8tv0IDS7mJsMrUwGp8Pima/1piPN4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-MK2O8sWWM9i8qLBJu_qVCA-1; Tue, 14 Jan 2025 05:27:27 -0500
X-MC-Unique: MK2O8sWWM9i8qLBJu_qVCA-1
X-Mimecast-MFC-AGG-ID: MK2O8sWWM9i8qLBJu_qVCA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so3020377f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850446; x=1737455246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52hrgni7t4Fn8Trrwho1Ps7RaGxj4Q0ZCrLW1+g7ROg=;
 b=wuR4YzRAkM41eECN/8dMLdxGfuCVKKwe+f97+B1W+pbhl9Mc8u/fCYdoe1aLR2mA3Y
 q/lPe4b1WCsO2LKoIcx8DuRnDEcQBtFlLwHtmyQG6KSWVmhn0Je08frRmmDRd44U0I6f
 qGQfWiPP8w3gwPOewbKqncLNAYO4Q6D3di3WjyVNLsQnALYtDC9BJifJMoF0XGZ1cHkM
 093oPwQm1rKV5wQNggufCT0tQ9doPPFfy7ghetUPJH9RiHhN65/wP32ah7PRpep8b4Up
 jdxl4QPC6Osl2T3Vy3EFja/3+CfYss9OJxq1W068dwHPonPBJn/BDRt3mJYMxF5/f3xS
 +Uyg==
X-Gm-Message-State: AOJu0Yy6leP+l5uG9SUZ90tAomey7PHUg0asTRxIZJ1TVyud05pE5rkq
 /SnkSqgvxW7knWwYQXVsiYZWg4DPIeFyybG79Ql0d1kSOZj4sT37F1+Y2CjY/M3UsKvM2TC9qIs
 DOCmGm51vN0iYnJk6IQ6xSa5KLEpC86AsXvhLH6dF/df9+SGeZrOeDF/7i2ri
X-Gm-Gg: ASbGncsvSTbFAJt+0sXuvzcXCpiHvYFqVehW45kM/KsJHRy4660Z1oUBfMVq2V5+Z8E
 ct8lYCdLiE6b7KnoDW4nSTU1mhg898JseZWuTbs71IGNW4mune05QI340mVKZluQFGbK4EBioFR
 mVc6RbnNess8YpFDVxlv90XMgMd1h7v6dBnTXymqVcQmV51z8sc9MGdpxpqbaaYZCnSFa6D0opO
 Ct1fpzSR93yhECuB5apkFB6Pc4Wwu7Azm8BEkEpv/Bsm3KeBw==
X-Received: by 2002:adf:ab0a:0:b0:38a:88bc:d57d with SMTP id
 ffacd0b85a97d-38a88bcd5efmr16884135f8f.2.1736850445905; 
 Tue, 14 Jan 2025 02:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpURLFloLkpfSnNBpli0UyQJx5Q1G61gHQy02odXTKNNwyEmqG+awlPcryGeBx4vqYJnZlLQ==
X-Received: by 2002:adf:ab0a:0:b0:38a:88bc:d57d with SMTP id
 ffacd0b85a97d-38a88bcd5efmr16884115f8f.2.1736850445501; 
 Tue, 14 Jan 2025 02:27:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:f243:3731:6014:d7c:f11f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d472sm14178863f8f.1.2025.01.14.02.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:27:24 -0800 (PST)
Date: Tue, 14 Jan 2025 05:27:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, eric.mackay@oracle.com, anisinha@redhat.com
Subject: Re: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Message-ID: <20250114052708-mutt-send-email-mst@kernel.org>
References: <20241210163945.3422623-1-imammedo@redhat.com>
 <20250114112054.6dcaa756@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114112054.6dcaa756@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 11:20:54AM +0100, Igor Mammedov wrote:
> On Tue, 10 Dec 2024 17:39:42 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > CPU hotremove event is not delivered to OSPM if the CPU
> > has been hotplugged before OS has booted.
> > For details see [2/3].
> 
> Michael,
> can you pick it up please?

yes it's in my tree that I am testing.

> > 
> > Igor Mammedov (3):
> >   tests: acpi: whitelist expected blobs
> >   cpuhp: make sure that remove events are handled within the same SCI
> >   tests: acpi: update expected blobs
> > 
> >  hw/acpi/cpu.c                                 |  43 ++++++++++++++----
> >  tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8593 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8504 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9918 bytes
> >  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15464 bytes
> >  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9057 bytes
> >  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10247 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8544 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5033 -> 5100 bytes
> >  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8665 bytes
> >  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9952 bytes
> >  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8451 bytes
> >  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8599 bytes
> >  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12386 bytes
> >  tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8422 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8439 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9747 bytes
> >  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12632 bytes
> >  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8701 bytes
> >  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8468 bytes
> >  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12035 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12980 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33837 bytes
> >  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8886 bytes
> >  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13213 bytes
> >  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10076 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8497 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8510 bytes
> >  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8439 bytes
> >  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9781 bytes
> >  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9552 bytes
> >  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13275 bytes
> >  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8302 bytes
> >  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8280 bytes
> >  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8428 bytes
> >  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8523 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12980 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33837 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9028 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9054 bytes
> >  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18656 bytes
> >  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14679 bytes
> >  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35785 bytes
> >  43 files changed, 34 insertions(+), 9 deletions(-)
> > 


