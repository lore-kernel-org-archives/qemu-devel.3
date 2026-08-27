Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C90C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wza9R-0007sy-Nf; Thu, 27 Aug 2026 09:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wza9P-0007sk-CO; Thu, 27 Aug 2026 09:28:15 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wza9N-0000Mj-Gj; Thu, 27 Aug 2026 09:28:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19A25600D3;
 Thu, 27 Aug 2026 13:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018051F000E9;
 Thu, 27 Aug 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787837289;
 bh=YoiuiV7BuiVkrt8iov95SFQ61pmnoDw60YzzsiWw5ms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TWTXxhtPSBhbUDlaXPW8owhBrzMuM51QNTsBlaYj8E3rogpmptJX9wqI6a5830ZTr
 N5hWNYG/3SL7Clty+bZ11ZgQ3pBlLqE+xWxHydkWV9j38ZEh+0ohY1tahqC2kS+Yy+
 irlGOnGnIq7yPxzH9joYvSDEGPhnDY0RvDt2tCpvPa0ssydYzuZF29MznUQC4fHfB8
 T3lzkt+663pSsv+7GLEpmFj/bGsit3k3OGNr3HaTVTtytTpNBDITf/14oBxrAJFXj8
 /8Oq0LlwLzDu9KPkzTmSLYyC+LNZpm3LGOtOlAjSvWWk4jm2zu+sIlnpHGyjRWqXex
 743b9W3tF90LQ==
Date: Thu, 27 Aug 2026 15:28:03 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
Message-ID: <apA7Y37myawAspZk@red-moon>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
 <apA2aSd4Gcic9vAP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apA2aSd4Gcic9vAP@redhat.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 27, 2026 at 02:06:49PM +0100, Daniel P. Berrangé wrote:
> On Tue, Aug 25, 2026 at 04:00:37PM -0600, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0,memory-backend=ram0 \
> >  -object rme-guest,id=rme0,convert-in-place=on \
> >  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> This example mentions 'convert-in-place=on', but I don't see that property
> implemented in this series. Is the example a mistake or is this from a
> further follow-on series yet to come ?

This series depends on Michael's patchset [0] as Mathieu mentioned in
this cover letter (+ a fixlet that was added in the QEmu repo reported
in this cover letter too that Michael should hopefully squash in in
his series to make it work for CCA and possible other arches).

[1] contains all of the above.

[0] https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[1] https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3

Thanks,
Lorenzo

