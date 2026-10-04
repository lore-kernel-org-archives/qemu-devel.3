Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70393CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDL2C-0001fn-QX; Sun, 04 Oct 2026 08:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anshumantewari123@gmail.com>)
 id 1xDJoY-00036J-OQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:51:30 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anshumantewari123@gmail.com>)
 id 1xDJoX-0005Hb-7j
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:51:30 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-34b1743e9c7so736121eec.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791111087; x=1791715887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
 b=CpgbKAYiBGbCiWZZqKjOL9CW+wOO0INFhSLHntZYeDEBNgPB1IdhL6OFaNkLH4p82S
 uGJsbZxWGdnTo+Na8OJfzHBucg4KkNA7bxAh0zViLrmxnpPue0eBkqVUBJ55Iq8FMa6O
 PUm+gtc70AvTftPMv1yCWX59VEo3bcNaROiGharGCJI73ilOK8KKC+RfbOlUXDD7A9Fp
 udCbYzlfW1qJ5mlehR53XL5auTpR62bw2xO9p5Jc2FilvSCxYo8wWm/0eHdokCGCZrk2
 MX6wI579aW7clPjW6DSBECE2eSlsim+vnnHv//ev7X+KwxMhReEwYv9lUE3tgsEbQHNi
 NxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791111087; x=1791715887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OU10JUkOnCjExkP9pLJslSiL15VSpV7uAw3VaBnuTMo=;
 b=upRItjUOsWytuEfZxDZ1KrOgrnaiCTmGEzUoS7uG+QHEG2lSJxSiot3FDT9XQ2EqkY
 VkHwjrQoKCWse9GFfeoqUZOoUe8qTtGJrW9n223P0dwozUfwdkNpg0nnigfKgsR84IRb
 Wb0UHhVLdJGtJJEGCVkUMlTH8eDmgn4Fqpey393AGRH3PdnjW9ncdwUISC3o0f9lE8Lk
 NWrMJFd5hHOIGz3ZzLo2PXd8XzRgggAh2ZZ9FG55Gn/8/dHZO33ta15IJvZ9tN4jkx1I
 9zRe0fgaogdoc3cwuLTQH6ACUuDLcGjOjVelHjO9wl/sg7WJ3wqfxYJhSiTOhvp1f+rO
 3X4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv6xTBZD2ASSGoKJCt5dSjgfBz7Kpu0clY0A+7L9J6KiuyxlVZ1V8/BXQfT8Pi1CI48e/ZYq7nSAm0@nongnu.org
X-Gm-Message-State: AFq9FYKL1Cpr2yC9Fifl5aXgzV5l+TNkYAHS/uxGGcyfsXoQf+++Ptgb
 yUoMabwyqG64FohgJJNCrJ1/JG+KcDAHPodEBXQwA+VkifAqWxub6wR0
X-Gm-Gg: AYBFou3VQAug4k/s6Ztgku5g02MU23+TDyUCYezH+T2QcYAyE0PYk+wJwIQFPEchrcj
 jJE6fyHYw0mKxdYOf+guywpWX9TUe28TcbKjQsBV+1JkoHK+SQ3nHxd1GJ/H+/toIDUDwEkiGxl
 Rgs9HYLFPdueNI/8IgSlXAhYwoNkdopjBankxMRQAOeKubJNSvKn7WNhLmreicU3z5z9MxFCvp4
 zR/U3lW2R8IgmtW0gIKlufQfx6eZco4SAbNqyPIViiLSRo9Pb6DBuuPfiyD1oQM852BAjQwHIU9
 Ffv1Us5rZ1/GC1mPG5P5i3w1msSSp9PLP4BhXHftOQ1/+AupGFq2Tew7q8l0Qqzh8V5C2xNbmQ8
 PCgsPPV5fNNRQRdEfzVfvtxhZ6G8TTYRN2coeOaQD14qrEpC/UgGLkKLof1WeBcCyOkv+h5humT
 BY//YpAP00ol/bk7t5LRIORw3B7BkIhw6+CMxxL6rrWK4muYU9OK2MyLeSEzFam4pzueMR1q7nw
 KWYnwY38bH9N5eSWAMdD43FMO50hqR+170cyoEGl78dNEs=
X-Received: by 2002:a05:7300:e5c2:b0:341:3ca2:de2d with SMTP id
 5a478bee46e88-34f15077edfmr9383419eec.6.1791111087081; 
 Sun, 04 Oct 2026 03:51:27 -0700 (PDT)
Received: from Anshuman ([123.63.59.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127161474sm3815965eec.13.2026.10.04.03.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:51:26 -0700 (PDT)
From: Anshuman <anshumantewari123@gmail.com>
To: kees@kernel.org
Cc: Frank.Li@kernel.org, James.Bottomley@HansenPartnership.com,
 airlied@gmail.com, akpm@linux-foundation.org,
 andriy.shevchenko@linux.intel.com, anton.ivanov@cambridgegreys.com,
 apparmor@lists.ubuntu.com, atomlin@atomlin.com, benjamin.berg@intel.com,
 bhelgaas@google.com, bp@alien8.de, bvanassche@acm.org, corey@minyard.net,
 da.gomez@kernel.org, daniel.lezcano@kernel.org,
 dave.hansen@linux.intel.com, david.e.box@linux.intel.com,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dvyukov@google.com, elver@google.com, eperezma@redhat.com,
 georgia.garcia@canonical.com, glider@google.com, gor@linux.ibm.com,
 gregkh@linuxfoundation.org, hansg@kernel.org, hare@suse.de,
 hca@linux.ibm.com, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 jasowang@redhat.com, jbaron@akamai.com, jgg@ziepe.ca, jim.cromie@gmail.com,
 jirislaby@kernel.org, jmorris@namei.org, johannes@sipsolutions.net,
 john.johansen@canonical.com, joonas.lahtinen@linux.intel.com,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, lenb@kernel.org, leon@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lukasz.luba@arm.com, macro@orcam.me.uk,
 martin.petersen@oracle.com, mcgrof@kernel.org, mchehab@kernel.org,
 mingo@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, paul@paul-moore.com,
 pbonzini@redhat.com, pengpeng@iscas.ac.cn, peterz@infradead.org,
 petr.pavlu@suse.com, qemu-devel@nongnu.org, rafael@kernel.org,
 richard@nod.at, rodrigo.vivi@intel.com, rui.zhang@intel.com,
 samitolvanen@google.com, seanjc@google.com, serge@hallyn.com,
 simona@ffwll.ch, somlo@cmu.edu, srinivas.pandruvada@linux.intel.com,
 stable@vger.kernel.org, stern@rowland.harvard.edu, tglx@kernel.org,
 tiwei.btw@antgroup.com, tursulin@ursulin.net,
 usb-storage@lists.one-eyed-alien.net, virtualization@lists.linux.dev,
 vkoul@kernel.org, x86@kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Date: Sun,  4 Oct 2026 16:17:41 +0530
Message-ID: <20261004104741.51238-1-anshumantewari123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133326.2465264-1-kees@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=anshumantewari123@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 08:09:35 -0400
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

On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> if (!ret)
> 	break;

One question about the truncation behavior here: when an element does
not fully fit in the remaining buffer, this min() can cause only part
of that element to be copied. For example, if the remaining space is
4 bytes and the next element produces "123456789\n", the resulting
output could contain only "1234".

This leaves the reader with no way to distinguish a genuinely short
value from one that was truncated due to the PAGE_SIZE limit, while
the array otherwise still looks like a normal comma-separated list.

Is this partial-element truncation intentional for this patch, or is
the expectation that it gets handled as part of the later seq_buf
conversion? Would it be preferable to avoid copying an element unless
it fits completely, and leave the larger-buffer case to be addressed
later in the series?

