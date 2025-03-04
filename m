Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A298C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNAN-0007rx-VC; Tue, 04 Mar 2025 02:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNAG-0007ph-6w
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNA5-00037w-Nf
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=Fzcwuq9L71A/Lz+P80dIer8z9fyrhk0awCoiJC5Yu2M=;
 b=MSpu6Xw09nNjqlxQtWu7w9NBtFBMfHO8149rzIVhCbvps5KDxH15MVdvd2LRpWXZX5Pzk3
 qsP7x5vtKqOGS5k1WQxB9BtM3M6gEKAZV4SOgHlr58GCLCXmff2xwvUTUU8NfRaQP3pbCK
 GBZcXanh+7XGgXPoPWbSAVHu7hoGWaw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-AVU13HKFOcafc1S9RsNapA-1; Tue,
 04 Mar 2025 02:57:42 -0500
X-MC-Unique: AVU13HKFOcafc1S9RsNapA-1
X-Mimecast-MFC-AGG-ID: AVU13HKFOcafc1S9RsNapA_1741075060
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE62C1944D45; Tue,  4 Mar 2025 07:57:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74659180035F; Tue,  4 Mar 2025 07:57:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC1E821E66C1; Tue, 04 Mar 2025 08:57:34 +0100 (CET)
Resent-To: ltaylorsimpson@gmail.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, wangyanan55@huawei.com, zhao1.liu@intel.com,
 alex.bennee@linaro.org, philmd@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, bcain@quicinc.com,
 mlambert@quicinc.com, quic_mathbern@quicinc.com, quic_mburton@quicinc.com,
 quic_mliebel@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:57:34 +0100
Resent-Message-ID: <87plixw7m9.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  quic_mathbern@quicinc.com,  ale@rev.ng,  anjo@rev.ng,
 quic_mliebel@quicinc.com,  ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org,  quic_mburton@quicinc.com,  sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>,  Mike Lambert <mlambert@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/8] hw/hexagon: Add machine configs for sysemu
In-Reply-To: <20250301172045.1295412-3-brian.cain@oss.qualcomm.com> (Brian
 Cain's message of "Sat, 1 Mar 2025 09:20:39 -0800")
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-3-brian.cain@oss.qualcomm.com>
Date: Tue, 04 Mar 2025 07:27:56 +0100
Message-ID: <87frjtz4wj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> From: Brian Cain <bcain@quicinc.com>
>
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09..a7070bad4d 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -33,7 +33,7 @@



   ##
   # @SysEmuTarget:
   #
   # The comprehensive enumeration of QEMU system emulation ("softmmu")
   # targets.  Run "./configure --help" in the project root directory,
   # and look for the \*-softmmu targets near the "--target-list" option.
   # The individual target constants are not documented here, for the
   # time being.
   #
   # @rx: since 5.0
   #
   # @avr: since 5.1
   #
   # @loongarch64: since 7.1
   #

Please add a line "@hexagon: since 10.0".

   # .. note:: The resulting QMP strings can be appended to the
   #    "qemu-system-" prefix to produce the corresponding QEMU
   #    executable name.  This is true even for "qemu-system-x86_64".
   #
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>               'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',

[...]

With that doc fix
Acked-by: Markus Armbruster <armbru@redhat.com>


