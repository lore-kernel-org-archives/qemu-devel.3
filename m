Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0486CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8Ay-0003VL-NJ; Fri, 01 Mar 2024 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rg8Aw-0003V8-1B
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rg8Au-00052R-47
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709319842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3L9x+Y35KQvPXS8MjnFJhFgiIm4TNZebFPnW1Pxy8g=;
 b=e0q5KQtNlxjiWCHPtt70rH9kaGP0eMAquTWFGZJ1Yb+QVo3VfObqR7CJZhNN3uKEJ6M/0v
 DpMEp65NJBrr+k+vB4a5pV9mRVqq3QlOcczFRVb8HVBeRteTXE2ycmdSGXPoDr1ZTNsqdK
 kID8qDdMoaa128Ouo0ZGA1exuuFFG6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-WQFeNLDkP1mlqg9XfOrOIA-1; Fri,
 01 Mar 2024 14:04:01 -0500
X-MC-Unique: WQFeNLDkP1mlqg9XfOrOIA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF5FD3C0F198;
 Fri,  1 Mar 2024 19:04:00 +0000 (UTC)
Received: from [10.22.9.187] (unknown [10.22.9.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84EBB492C25;
 Fri,  1 Mar 2024 19:04:00 +0000 (UTC)
Message-ID: <1bc7cd73-e204-4ee8-8c38-2107ed379295@redhat.com>
Date: Fri, 1 Mar 2024 14:04:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-7.2.10 v1 00/47] Patch Round-up for stable 7.2.10, freeze
 on 2024-03-02
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On 2/28/24 3:35 PM, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v7.2.10:
> 
> https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2
> 
> Patch freeze is 2024-03-02, and the release is planned for 
> 2024-03-04:
> 
> https://wiki.qemu.org/Planning/7.2
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional 
> patches you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit
> hash from master branch, are given below the bottom line.
> 
> Thanks!
> 
> /mjt
> 


Response might be too late, But here's the patches we are still carrying
in Fedora 38 7.2.X and the explanations


* abe2c4bdb6 test-vmstate: fix bad GTree usage, use-after-free

  Fixes an intermittent crash in test-vmstate


* f2e57851b8 tests/qtest/display-vga-test: Add proper checks if a device
is available

  Fixes this reliable unittest error with device modules:
  476/657 qemu:qtest+qtest-ppc64 / qtest-ppc64/display-vga-test
           ERROR           0.71s   killed by signal 6 SIGABRT


* b6903cbe3a tests/unit/test-blockjob: Disable complete_in_standby test

  Fixes flakey blockjob test


* 2196157404 target/i386: the sgx_epc_get_section stub is reachable

  This is in 8.2.X series already, but applies to 7.2.X as well


Thanks!
Cole


