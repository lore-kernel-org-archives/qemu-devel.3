Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90159C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOz-0004VD-Ak; Wed, 21 Feb 2024 10:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rcoL9-00010D-Hn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rclIH-00021J-VF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708516904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GVyMoppQIVGnlcQxui5CGU/uqKWrw/Rgx65oFKrsIU=;
 b=IRd5Vn2zjlcOjemXKQloLJX7j1vT1Di58cy7TQ8a/wNrPPkBF46ZbcvQnZsxdhWAbXnynE
 6DAsY/ftrJjBx3JSFJQ9X8nuJoh4YBW0NYpRKxBQltmoBwaoxegA5HkdGuJBg0r55ZS9HX
 1jfJkVYrTpHp6+XlBsZm1TiSHXKxpTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161--JhWZdOYMFKu1rKkqsh1RQ-1; Wed, 21 Feb 2024 07:01:41 -0500
X-MC-Unique: -JhWZdOYMFKu1rKkqsh1RQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31C5083B82A;
 Wed, 21 Feb 2024 12:01:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75A1620169C6;
 Wed, 21 Feb 2024 12:01:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 450D81800DDB; Wed, 21 Feb 2024 13:01:39 +0100 (CET)
Date: Wed, 21 Feb 2024 13:01:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <pksfgvk7xhb73veclelzlu4oys2y7a4xu2ayepzolw25g322cd@bebiiammn5a3>
References: <20240220154204.29676-1-anisinha@redhat.com>
 <ZdTKYV5AuhYxvi1Q@redhat.com>
 <vp63d36mcuib6trlqyjqpy72ysxb7ftlodr3eldhqklfg7bqi6@zc74olpzwknw>
 <4608F5FA-584C-4FE9-A73A-EBEF1E7B7FEA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4608F5FA-584C-4FE9-A73A-EBEF1E7B7FEA@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  Hi,

> Looking at the edk2 GH, are these the PR that are waiting for upstream review/merge that relate to vcpu scaling?
> 
> https://github.com/tianocore/edk2/pull/5375
> https://github.com/tianocore/edk2/pull/5327

These are draft MRs for running CI.

The current devel branches are:
  https://github.com/kraxel/edk2/tree/devel/many-vcpus
  https://github.com/kraxel/edk2/tree/devel/many-vcpus-mpinitlib

All of them will expire at some point though, so I don't think it is a
good idea to include them in the commit message.  They will point into
nowhere in a year or so.

take care,
  Gerd


