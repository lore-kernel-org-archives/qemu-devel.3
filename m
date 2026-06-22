Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C1FCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbeBs-0006b8-L9; Mon, 22 Jun 2026 08:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbeBY-0006YR-G0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbeBS-00076C-JJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DvTwaqpf3wczlNBTv0/g2+uDpueJ/mvWIF5BQGskw/A=;
 b=WYIUC6rtI3YYxe+rMX6SlvLn6Eap7HxQqQsNiD3j5NYnaT8VkTOdjzRR4DQQ+xHyecBfcY
 dsJHdrcscQ2TtwWnAbx+XSLjmXJBoSC7p3ysCR6BPGGVyvEvGLyPEfmLq+IeOT3hhKKNUU
 iGC1gSnKk1HrunR7jygiiV9uCUCWxz8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-KR4-EWlpOm2xGZ2qYs1PLA-1; Mon,
 22 Jun 2026 08:55:19 -0400
X-MC-Unique: KR4-EWlpOm2xGZ2qYs1PLA-1
X-Mimecast-MFC-AGG-ID: KR4-EWlpOm2xGZ2qYs1PLA_1782132918
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D86F41955F28; Mon, 22 Jun 2026 12:55:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.119])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ACC71800594; Mon, 22 Jun 2026 12:55:13 +0000 (UTC)
Date: Mon, 22 Jun 2026 13:55:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 mst@redhat.com, gourry@gourry.net, philmd@mailo.com,
 peterx@redhat.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v13 02/10] qapi, hmp: introspection for the sp-mem device
Message-ID: <ajkwrj9DncqDzWoN@redhat.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-3-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260619111136.3481329-3-FangSheng.Huang@amd.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 07:11:28PM +0800, fanhuang wrote:
> Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devices`
> reports each sp-mem instance (id, addr, size, node, memdev), and print it
> from HMP `info memory-devices`.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
>  hw/core/machine-hmp-cmds.c | 11 ++++++++++
>  hw/mem/sp-mem.c            | 19 +++++++++++++++++
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..777cfc81e1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1413,6 +1413,32 @@
>            }
>  }
>  
> +##
> +# @SpMemDeviceInfo:
> +#
> +# sp-mem device state information
> +#
> +# @id: device's ID
> +#
> +# @addr: physical address, where device is mapped
> +#
> +# @size: size of memory that the device provides

Is this bytes ? Please include the units in the comment.

> +#
> +# @node: NUMA proximity domain to which the device is assigned
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpMemDeviceInfo',
> +  'data': { '*id': 'str',
> +            'addr': 'size',
> +            'size': 'size',
> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


