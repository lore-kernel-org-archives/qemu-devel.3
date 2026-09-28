Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F71AC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8NC-0007Nf-6c; Mon, 28 Sep 2026 06:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB8N2-0007N3-FZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB8N0-0001ei-9z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790590440;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WfspKtklugh/OYlKtKuxjrPv/b7W5PFR1FRmVmYBQRs=;
 b=EX9uSR/2mpihPkKFA8/uBHiE+aR//AMaWiI1F6WJoOt7hMZVCu3L1j5zj+8Pq1PpAZKBx0
 S8MnftbzMms8FACzrGhLrsQ9GMMWqp2eT7uflpsMT9xWqhy+sKdOIR1BhonoKtKmXio+v8
 fITKALVNw3/rTm4vZfyWGCLJEF9Ay6I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-3q5wHjZTPt24_x-CQkTmEA-1; Mon,
 28 Sep 2026 06:13:57 -0400
X-MC-Unique: 3q5wHjZTPt24_x-CQkTmEA-1
X-Mimecast-MFC-AGG-ID: 3q5wHjZTPt24_x-CQkTmEA_1790590435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D72B1954229; Mon, 28 Sep 2026 10:13:55 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 848C01956095; Mon, 28 Sep 2026 10:13:51 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:13:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Message-ID: <aro93NuZBXYGbD33@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926070057.1234-47-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> query-targets lists each linked target, including none, with its
> arch, endianness, and the machines that target accepts.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>  qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)


> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6aaa2af709a..d8cdea6203e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -307,6 +307,41 @@
>  ##
>  { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>  
> +##
> +# @TargetMachines:
> +#
> +# One registered system target and the machines that can run on it.
> +#
> +# @arch: the target architecture
> +#
> +# @endianness: the target endianness
> +#
> +# @machines: machine type names, not aliases
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'TargetMachines',
> +  'data': { 'arch': 'SysEmuTarget',
> +            'endianness': 'EndianMode',
> +            'machines': ['str'] } }

We already have  'QemuTargetInfo' struct which is used
with 'query-target', that should also be used with the
new 'query-targets' command.

We need to add the 'endianness' field to QemuTargetInfo.

I don't think that we need to report machines though.
We already have 'query-machines' which gives much broader
information on the machines. "MachineInfo" needs to
gain

   "targets": ["SysEmuTarget"]

to list which target(s) a machine can be used with.


> +
> +##
> +# @query-targets:
> +#
> +# Return each target linked into this QEMU binary and the machines
> +# whose availability check accepts that target.
> +#
> +# Since: 11.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-targets" }
> +#     <- { "return": [ { "arch": "aarch64", "endianness": "little",
> +#                        "machines": [ "virt" ] } ] }
> +##
> +{ 'command': 'query-targets',
> +  'returns': ['TargetMachines'] }


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


