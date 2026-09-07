Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8772C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Tih-0000Kw-Oj; Mon, 07 Sep 2026 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3Tig-0000KQ-5g; Mon, 07 Sep 2026 03:24:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3Tid-0001x2-Tx; Mon, 07 Sep 2026 03:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1788765856; bh=XYEpqqpHVv/RtpomFf0RuS+1ZWcSgym38qwxWnxvzcM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CBLmLAVycDQdvYxjBr5X7wIcJY4ZDDrA5XW7v3HUM60XOeTPaAKro87/1fhIl+uJa
 ai24cK+dS1hAsGoJqTXy9DYXuotgRIwyj+WICEqnhwh0Ryf1SNN0zEiwDJ1BE8VSjP
 P1q3YvUi2n6nDOr8lTf68c9d3qpjOGhpQWk6eCCGLd7DM9fuTGGAfwPu9+peLotfEK
 K9Z9oJWCNospsxTVMaq4eW1BXhXasbmfAWaOvMAKhX7IjGJTziXBKZ8IdDHGneGdy3
 qCy7kBe7/pJXY3rl0+QqQEWt8RHcIFkh6wIxWXbxF2ebNNc5Vnk5KEZDjlFU4zjqSu
 EI6UPTlwOC1YA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9BD091D2339;
 Mon, 07 Sep 2026 10:24:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E7B5E4227FD;
 Mon, 07 Sep 2026 10:24:40 +0300 (MSK)
Message-ID: <5ffaa368-e962-4fed-ac4e-62a8469d9cb2@tls.msk.ru>
Date: Mon, 7 Sep 2026 10:24:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 01/14] qapi/misc: Fix missed query-iothreads items
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?=27Daniel_P_=2E_Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: qemu-stable@nongnu.org
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-2-zhangckid@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260907063725.626685-2-zhangckid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/7/26 09:37, Zhang Chen wrote:
> The example is incomplete: it misses members @poll-max-ns, @poll-grow,
> @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
> (monitor: add poll-* properties into query-iothreads result) and
> commit 1793ad0247c (iothread: add aio-max-batch parameter).
> 
> cc: qemu-stable@nongnu.org
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>


This is not technically a part of "iothread: Support tracking and querying
IOThread holder" series, it's a bugfix by its own.  Can we apply this one
without the rest?  I can do it through the trivial-patches tree but it
looks like it should go to the qapi tree.

Thanks,

/mjt

