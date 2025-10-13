Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6EDCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8AxS-0000VZ-Rf; Mon, 13 Oct 2025 01:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8AxR-0000VR-EY
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:18:53 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8AxP-0008BP-Mm
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:18:53 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 6A11314C2DE;
 Mon, 13 Oct 2025 07:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760332730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IB4HFQNtLMWIOghw6xn4/eC6pfOl2twNLQ9ZjcbWfGs=;
 b=Ry10nbC0mZTj0DrBaOlkkzCAII5m7ODFqf0FiRR0hm7veHySLll0D1jH9hles/J4rJZJg1
 jaT80gGaghn0G1jz9mKEa+mV4f8CG5O/qOu7+r+EadWQEEbCs/dz4YBEKewnLFK2mS1pXx
 WH9YFUxkICLvuay5dm12Tn27aCEV7a28pOfgpI4i6UgL3IyUaqTNFJRhPpDuxrjMGZp25F
 MCuQgsT+hf/kn3WfvOQezeMdYosMOPwpTe6IVb53qqEiS25zm1e7Ux0ckmFxjXwiu6ky7g
 NEqpKHFbpAj8Ev0FT3S5KzO8bseoX27kqZA75LsIVF4kUrzp29qXBYUIp78pIA==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3491d954;
 Mon, 13 Oct 2025 05:18:43 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:18:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 07/12] qmp: add chardev-window-size-changed command
Message-ID: <aOyLpF0-qZKbkflk@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:37AM +0200:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> The managment software can use this command to notify QEMU about the
> size of the terminal connected to a chardev, QEMU can then forward this
> information to the guest if the chardev is connected to a virtio console
> device.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> [Filip: rename command, change documentation]
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
Tested-by: Dominique Martinet <dominique.martinet@codewreck.org>

(checked with stty in guest after running the command)

-- 
Dominique Martinet | Asmadeus

