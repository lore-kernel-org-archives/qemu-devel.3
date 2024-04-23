Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E107C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 14:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGsP-0007Sk-IF; Tue, 23 Apr 2024 10:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rzGsK-0007SR-Fe
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rzGsJ-0005fm-0M
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713881516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IvDdc2fQRfAwgOmAMT4FnFkQbIiBZPyZEuxWbUmHIFY=;
 b=RtKTofvh+bBL2HdhS4XfoihdZGvQyhO37lnuf8mSjME3VkwjvPLzqdmHQfogZ/4abxuxmD
 Le9uqkqKkoxUwKjOLXSm1m9bKQB4/A5fY8qXO3GBqS//7isNf4pHlNmM6t+reRd0PZ6cVE
 Ip1OChb3jpFWOpQAOvM3UQOfQ0T2810=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-cMS1RZ0BPcaQFjX3kmt2Lw-1; Tue, 23 Apr 2024 10:11:52 -0400
X-MC-Unique: cMS1RZ0BPcaQFjX3kmt2Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB9E3811029;
 Tue, 23 Apr 2024 14:11:50 +0000 (UTC)
Received: from [10.22.9.159] (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A78A31C060D0;
 Tue, 23 Apr 2024 14:11:50 +0000 (UTC)
Message-ID: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
Date: Tue, 23 Apr 2024 10:11:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cole Robinson <crobinso@redhat.com>
Subject: hppa-firmware.img missing build-id
To: deller@gmx.de
Cc: qemu-devel <qemu-devel@nongnu.org>, "Richard W.M. Jones"
 <rjones@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

hppa-firmware.img and hppa-firmware64.img in qemu.git are missing ELF
build-id annotations. rpm builds on Fedora will error if an ELF binary
doesn't have build-id:

RPM build errors:
    Missing build-id in
/tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware.img
    Missing build-id in
/tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware64.img
    Generating build-id links failed

I didn't hit this with qemu 8.2.* builds FWIW

Thoughts?

Thanks,
Cole


