Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC20CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3wW-0001LB-8u; Thu, 21 May 2026 10:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xQ8PagYKCngoaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com>)
 id 1wQ3w4-00087N-TZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:41 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xQ8PagYKCngoaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com>)
 id 1wQ3w3-0002k9-0r
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:40 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c8279604464so9098290a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779371975; x=1779976775; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
 b=CqvajJUSmypkDnH42ewlNvqcXwI9LfsFwGPJhu3oNq0MvdAKS1lCNq31dV/vY9kgcg
 O4hnpymtVnD02dfDPbmadnwDMvsM1NV+79RR359iW5uJp9x+o7omALXtK8LIM43ksiqL
 GwHla6UPKspKiE4zFnc71SDHclc4fh9FO5MIrq0MGRI8pVOyL3cP+KBgGo7k08mbOMkj
 wy5HWYgNhUGgLpEzGkVJNpXZqqexbcgqVDfMwUYKb3JYXsyA63Rjcwaz9UUR9XEKUgDI
 Kziaiqa3NOcKfv4P0HtRcyvOSIVCkw4bdrXlv324IHlmdA+b9JIykrd5/vRdvZsID4K8
 Sh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371975; x=1779976775;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
 b=lYF+K+eaDw/T+XqscCR5pAWa/Id59vgBNCbyJ1qIdvyN5ov/Afc34iSkKjcsbSSaxj
 kheFlQHwKVBmQRuwn9DvEyWuWiu8NODtYYaktWUyariajuMW3uXJqjf51AGMJocF4M/l
 mQm3BHwuIi2sK0Cu7nj4qZbRtdolb1fQp3DDg3yV58GlkObPtFzzgYa9HIrCtuAIiqH0
 bx9TF76STi9HR/qWfnHSaAQfTc9yT+Cc4+uA11LP0p3N4rCGVvbHsc3K/F/3dRwq4OvX
 ozat33jnd1o64CF+LJ+La6WOKMnV/j7aQQc9E7v+VdebLJncxsMn21xFoDKZu9UwL+V4
 UoCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u/g9U3G4Bf6NwDEk2iGaaJli0Dvhrjr9iPcQCeOzN56ztLDcVrTuSymR8zqVa7/QQxNfT/n0S3Cet@nongnu.org
X-Gm-Message-State: AOJu0YwqxTi6M/7xutic3egf5sMgeShNMKxmUyEZ21BS/o8g9y+1h3j3
 kjVGB1pm/SDR9QyY/xyqfLy8CTdgi4ANOxhE2ZojMaBQ161PdzwdKjPppJecDN6UejOiSisitvq
 rhhNMpg==
X-Received: from pge1.prod.google.com ([2002:a05:6a02:2d01:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431a:b0:39c:a78e:dba9
 with SMTP id adf61e73a8af0-3b308ac1b14mr3725831637.40.1779371973881; Thu, 21
 May 2026 06:59:33 -0700 (PDT)
Date: Thu, 21 May 2026 06:59:33 -0700
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-4-kees@kernel.org>
Message-ID: <ag8PxTTi5NxT51EW@google.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, 
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, 
 Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
 Benjamin Berg <benjamin.berg@intel.com>, 
 "Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3xQ8PagYKCngoaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026, Kees Cook wrote:
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);

IMO, "OPS, GET, SET" is more intuitive, especially since that's the order used
by DEFINE_SIMPLE_ATTRIBUTE and DEFINE_DEBUGFS_ATTRIBUTE.

