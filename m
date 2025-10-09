Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3929CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6p1R-00081k-EP; Thu, 09 Oct 2025 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v6p1N-00081A-Mq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:41:22 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v6p1H-0005Bm-1l
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=iGljD3PrM0SPifuG12leOCv9//BjDBDvOjuQuhn9WyE=; b=B+so5T4MtN/7NpyN
 kPGaj2eZA3EastluDPUD3eT0DXzzDVuNWCyxa6+Au1JycoSIeoFyHqxgzzq95xHNaSsfgW19bFOjx
 4f4sFd48BLblemqBBXulBdVoZFeaC/aUGqFAf3HLIJjDl/3+HQuGrHPtAX4MRgSRP9O3itrVSvdWv
 kdI7DAypgkzJJ+nw9S6VZl9gJDxehdskB4Y4+YiJUop4jvwKMIy7I/Y+zeGyeQjcqU4vilAz+Iars
 xFJAkip3b+UZFp4/ZiSLQfFNYLRYDb29/bqIjGF03kl4Y1/rqtdyQmXOxcwZKMMErXCAXmDy4tsqd
 T0EW3gHQ066BAPvzcg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v6p16-00FTyG-25;
 Thu, 09 Oct 2025 11:41:04 +0000
Date: Thu, 9 Oct 2025 11:41:04 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOefUN5_bSKjWPLc@gallifrey>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <aOcWOQJt-zLbiyUK@gallifrey> <aOdggKKyDtf3z57J@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOdggKKyDtf3z57J@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:08:27 up 164 days, 19:22,  1 user,  load average: 0.12, 0.07, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Oct 09, 2025 at 01:56:09AM +0000, Dr. David Alan Gilbert wrote:
> > * Gerd Hoffmann (kraxel@redhat.com) wrote:
> > > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > > optional support for logging to a memory buffer.  There is guest side
> > > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > > But that might not helpful if your guest stops booting early enough that
> > > guest tooling can not be used yet.  So host side support to read that
> > > log buffer is a useful thing to have.
> > > 
> > > This patch implements both qmp and hmp monitor commands to read the
> > > firmware log.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > I'm OK with that, but I wonder if it would be better to have a command
> > that wrote the buffer to a file rather than displaying it directly; I don't
> > think we normally have anything else which outputs that much raw guest
> > provided data directly.
> > I assume when it goes wrong you end up with random unprintable junk in
> > the buffer.
> 
> 128 KB is on the high side, but is not terrible. Libvirt (arbitrarily)
> caps a QMP reply at 10 MB. Libvirt is going to want to send this on to
> the client app and will likely do that streaming in memory, so having
> it iin a file is not required from our POV.
> 
> IIRC, some of the query-block command replies can get insanely huge
> when the qcow2 chain is very long.

OK, what about sanitisation - if that text contains random binary what happens,
or should we make sure it's sanitised?

Dave

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

