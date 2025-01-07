Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7600E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7QU-0007QZ-8X; Tue, 07 Jan 2025 06:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV7QR-0007Pf-FF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV7QN-0008Uk-Sw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736248022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7TY6FOA/5GVfR6ug7DM96NEwsyvBbxsgWbqcSbHB+8=;
 b=fehyXgXzbJZouqi62BW1E/uMWgdZA481wXVdabmzxFsunNTCmu76WpOO+OJYdX8tipbRcf
 gJNr8vvhTgx+3XumsJZfuLNYhzKROqXYXM01U6BpqJsXef0uC2SVCp8kBvCqteqzjMuxXp
 JQdwse9LGiAja9XkCKihZqo5vP4Qpuk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-Yq9rhTYDN2KN32XGMpNE5Q-1; Tue,
 07 Jan 2025 06:06:57 -0500
X-MC-Unique: Yq9rhTYDN2KN32XGMpNE5Q-1
X-Mimecast-MFC-AGG-ID: Yq9rhTYDN2KN32XGMpNE5Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC4419560A3; Tue,  7 Jan 2025 11:06:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D33061956088; Tue,  7 Jan 2025 11:06:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8315321E6924; Tue, 07 Jan 2025 12:06:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org,  Song Gao <gaosong@loongson.cn>,  Bibo Mao
 <maobibo@loongson.cn>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/23] qapi/machine: Replace TARGET_LOONGARCH64 with
 TARGET_LOONGARCH
In-Reply-To: <20241226-la32-fixes1-v2-21-0414594f8cb5@flygoat.com> (Jiaxun
 Yang's message of "Thu, 26 Dec 2024 21:19:52 +0000")
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-21-0414594f8cb5@flygoat.com>
Date: Tue, 07 Jan 2025 12:06:52 +0100
Message-ID: <87wmf6ann7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Jiaxun Yang <jiaxun.yang@flygoat.com> writes:

> All TARGET_LOONGARCH64 qapis are also available for LoongArch32 as we
> are reusing the same CPU backend implemenation.

As far as I can tell this makes query-cpu-model-expansion and
query-cpu-definitions in the LoongArch32 build, too.

> Use TARGET_LOONGARCH to identify LoongArch.

Suggest to be more explicit. e.g. like this:

  The QAPI commands specific to target loongarch64 are wanted for
  loongarch32, too.  These are query-cpu-model-expansion and
  query-cpu-definitions.  They just work, since the two use the same CPU
  implementation.

  Replace TARGET_LOONGARCH64 by TARGET_LOONGARCH.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Preferably with an improved commit message
Acked-by: Markus Armbruster <armbru@redhat.com>


