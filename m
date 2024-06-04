Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516A9C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEMje-0001sa-C2; Tue, 04 Jun 2024 01:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEMjc-0001sI-Ck
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEMja-000322-I6
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717478961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NsbPceQL/VMJR8Bm4w5Su7aNOC8NkgYYbfXuE4cWCcU=;
 b=OfAamudlo7IF2RU2e6Ox+dzXbTFjAvU0M0qlGqQWEDWIsUJ0fs4FIsK9jYXKpknkbF5qMn
 OKtCHzWY1Che9hTvEE13GFUOuj6PLeCOIVdFtgMCJkJfaASOCK7aGYOH3trsutBdyB0CIT
 W7O5eviwe4cAgy6peZXP7SWJKwFvVeg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-RDf2GsT0MhODE94-189IXA-1; Tue, 04 Jun 2024 01:29:18 -0400
X-MC-Unique: RDf2GsT0MhODE94-189IXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A28BC185AD2C;
 Tue,  4 Jun 2024 05:29:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9DE12028B59;
 Tue,  4 Jun 2024 05:29:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B46DD21E66E5; Tue,  4 Jun 2024 07:29:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
In-Reply-To: <Zl6U5n+QeEAiCBBv@intel.com> (Zhao Liu's message of "Tue, 4 Jun
 2024 12:15:34 +0800")
References: <20240527131837.2630961-1-zhao1.liu@intel.com>
 <87sexus0m0.fsf@pond.sub.org> <Zl6U5n+QeEAiCBBv@intel.com>
Date: Tue, 04 Jun 2024 07:29:15 +0200
Message-ID: <87r0ddcm38.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> On Mon, Jun 03, 2024 at 01:54:15PM +0200, Markus Armbruster wrote:
>> Date: Mon, 03 Jun 2024 13:54:15 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Use CPUTopology to honor the generic style of CPU capitalization
>> > abbreviations.
>> >
>> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> 
>> Is CPUFoo really more common than CpuFoo?  It isn't in the qapi
>> schema...
>
> Hi Markus, do you think this style needs to be standardized?
>
> All-caps cases, like the widely used CPUState.
>
> And the common structures declared in include/qemu/typedefs.h, are all
> using CPU, not Cpu...
>
> If you feel this is necessary, I'd be happy to help more places change
> their names to standardize their style...

The situation is unfortunate[*].  The renaming cure could be worse than
the disease, though.

In a situation like this, settling for local consistency is often the
least bad.  machine.json is locally consistent: it consistently uses
CpuFoo.


[*] We suck at systematic, disciplined naming.


