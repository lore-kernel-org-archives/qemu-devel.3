Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DDC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 22:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9tCT-00076N-J3; Tue, 29 Apr 2025 18:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tCS-000768-9h
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tCQ-0006Yb-HC
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745964786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH3hwuXScv4P9A+fBia1VI5JbdfsQV8bAGrRn4iDYKM=;
 b=cexVBhLNW69UkOVxe+YR/b6M6NAVsBaKgLGQB7roOb59Fdkvfe+cZgVNpSDzHwDXKDAccw
 cyJT/5A13x5DNNXJgVMXEIxdDxDzmCu2jnow03aWw3pFv3QT09W+SaRty7UDpEv9eMsy4k
 63nnaN+BE58GxIZGdITKZOr0BQGHcEs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-krR_4sXRNpaSVT5u9izNPw-1; Tue, 29 Apr 2025 18:13:05 -0400
X-MC-Unique: krR_4sXRNpaSVT5u9izNPw-1
X-Mimecast-MFC-AGG-ID: krR_4sXRNpaSVT5u9izNPw_1745964785
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e8f184b916so153159416d6.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 15:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745964785; x=1746569585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH3hwuXScv4P9A+fBia1VI5JbdfsQV8bAGrRn4iDYKM=;
 b=XXc2sUluoQ2mPHvilx2QUzThXu19kvubuOGqu5fdde6TX1bMWUAebFZ5wcZUHn+o2I
 nuL/QZTYufEyqGbHnEe+brm9VI1NFEAZIN9btR6QBvgFktPJ1zMIPVYSeMpTbiNsU4U1
 7rrtKtuh9Fyo6cnUVM/qvNFgh1v3eeRT6e5kq4H7bMQAqrdaZ0HEGgXAK3lINlSNr4Gs
 gbNMU0b+P9mZQBGTVqgBe5zU/GcnYbARMx1cTmJFAB3sQnZll5Fbb59wbnMGihCC5ZQy
 kPzXu5RV9q2nT72NGPPZJhpdKeZI/frdosHuxioTfzlVP8mqxpqh3qyBFRBBT0UpphWY
 zKoQ==
X-Gm-Message-State: AOJu0YyY31Ph1M8t7Yef+Wk00tYbpc0jKAd28qC0t7TU9Uvd12v9RcDO
 oP1IVRqLpHUu2XNsSWgwwX6GHiQkxL/fY/tPf7HJrB3cJsoMpE6CyITi6Y/YbedVsBV7YwY/OxY
 H/SmLtDvE/Z7PiKDRfzuywAhyuOVuhhgBU/75qpKE0ICaVyUTZzFv
X-Gm-Gg: ASbGnctKMUpUmIomU9GbKQ6rmOX0pN3laz/OJxNzxHGUb/ic8cNXLN+wRA12H32WgmL
 T+HWPCMJ+tl2hdFb8egnF3Kay2zBYLYfFSrYAxA9Fc1uGFo/md2k/vtnw4rkyhsLzgJWjWNrGz1
 /JAYPvx5AZ1QS4CvNfU+z58nSSV4MON7x05GmOWyV+8rdD1sFfH8bql6s+8sj1hYzJhemVaA+zE
 SkvZoafz1yPp0dZ3U+TT0p5+gMQ/5bncm3BDZgHHmQH6Rhg8+h6RuGBGGIsAAcxcN56TKdJUEee
 IfQ=
X-Received: by 2002:a05:6214:2623:b0:6e8:9d00:3d67 with SMTP id
 6a1803df08f44-6f4fe057f16mr7835886d6.15.1745964784771; 
 Tue, 29 Apr 2025 15:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5KwT3HU8QVpxFdsdxLAToyTsARWFAHmWRo+9bTHZ2Ts+5PFdL6ynxmoyTYU8pjMNchCQHAg==
X-Received: by 2002:a05:6214:2623:b0:6e8:9d00:3d67 with SMTP id
 6a1803df08f44-6f4fe057f16mr7835446d6.15.1745964784331; 
 Tue, 29 Apr 2025 15:13:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe6d19d1sm741546d6.48.2025.04.29.15.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 15:13:03 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:13:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/4] tests/vmstate-static-checker-data: Remove old dump
 files
Message-ID: <aBFO7DcBWYpOp0-Y@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429152141.294380-2-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 05:21:38PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These files reference QEMU machine types that have already been
> removed and thus are of no use anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I never noticed these files, but when looking it seems to me these two
dumps are tailored to be used to test the script itself..

See:

$ git ls tests/vmstate-static-checker-data/
e178113ff6 hw: Replace anti-social QOM type names
38ef86b5a6 tests: vmstate static checker: add size mismatch inside substructure
af3713f6b9 tests: vmstate static checker: add substructure for usb-kbd for hid section
c7173a9c18 tests: vmstate static checker: remove Subsections
aa2a12bb82 tests: vmstate static checker: remove a subsection
b5968f0ab3 tests: vmstate static checker: remove Description inside Fields
ff29b8573f tests: vmstate static checker: remove Description
083bac3484 tests: vmstate static checker: remove Fields
1d681c712a tests: vmstate static checker: change description name
fd52ffb9bf tests: vmstate static checker: remove last field in a struct
55e8e0e19c tests: vmstate static checker: remove a field
ab99bdbe33 tests: vmstate static checker: remove a section
7daa3d76df tests: vmstate static checker: minimum_version_id check
4efa6e1d64 tests: vmstate static checker: version mismatch inside a Description
a81d3fad87 tests: vmstate static checker: add version error in main section
bc178dc563 tests: vmstate static checker: incompat machine types
a10413e4fc tests: vmstate static checker: add dump1 and dump2 files

So dump2.json was deliberately modified to trigger all kinds of error that
the python script can detect.

Maybe we can still keep it there, but at least make it clearer that it's
testing the script?  For example, we could create a bash under the same dir
running the script over the two dumps and comparing the results to be the
expected one?

Currently the output:

$ scripts/vmstate-static-checker.py -s ./tests/vmstate-static-checker-data/dump1.json -d ./tests/vmstate-static-checker-data/dump2.json 
Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
Section "fw_cfg" does not exist in dest
Section "fusbh200-ehci-usb" version error: 2 > 1
Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
Section "cfi.pflash01": Entry "Description" missing
Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
Section "sun-fdtwo" Description "fdc": version error: 2 > 1
Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2

So the bash can make sure the result is exactly that.  If we want, we could
even route that to CI, but I'd say optional.

-- 
Peter Xu


