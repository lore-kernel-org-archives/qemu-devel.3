Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAC606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=oylPbXW2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKMM-0006Gh-K6; Fri, 20 Nov 2026 03:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUKMD-0006Dc-IG; Fri, 20 Nov 2026 03:52:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUKMB-0001F5-02; Fri, 20 Nov 2026 03:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795164745; bh=zgeEd154EtSxc2cxAhTa50F/j4K9qmwPc+357Crfz/c=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=oylPbXW2XaZfV229ji71YZTJ6o/UwAbpCL5sJ+WSJ/4Tl1g4XLqvr923UpLyzxC2K
 tbqLuuWESqbitllb0P8w82PHNVUUfORaBkOUEYbT9ZwRKjdyPC0yT4pvMnUQMRiCF5
 qBysOJb2L/mU52WvXvMAOBoTKdm/vfzESy7umHOM9uvMBBzd4ePWAuftTEwIsFS+GV
 k3hK7KiSccmLR86b9BN0lQslYQPkiQImw+DXV3GmkghN0nXtV9UZ/tiHF2gR0ff9ci
 eX+VThQGs8EV2jJo64ABBglsVJ/9PjP18yHpvj3xE/PAMG4ZCgmSXAoPeFx7wWtsl5
 iBviAXdWsegQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E47D31E839B;
 Fri, 20 Nov 2026 11:52:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D7FF5461F35;
 Fri, 20 Nov 2026 11:52:25 +0300 (MSK)
Message-ID: <4ceec3cf-6903-4cd9-84e3-6522ffc67a1a@tls.msk.ru>
Date: Fri, 20 Nov 2026 11:52:25 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-11.2 0/3] NBD patches through 2026-11-19
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261119202330.3853797-5-eblake@redhat.com>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261119202330.3853797-5-eblake@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 23:23, Eric Blake wrote:

> NBD patches for 2026-11-19
> 
> - Eric Blake: CVE-2026-126657: heap leak on client to malicious NBD server
> 
> ----------------------------------------------------------------
> Eric Blake (3):
>        nbd: Refactor structured payload interpretation
>        nbd: Pass back offset/length for all structured read replies
>        nbd/client: Don't leak uninitialized memory on malicious server
> 
>   block/nbd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 73 insertions(+), 14 deletions(-)
> 

Hi Eric!

This patchset contains a single patch which is marked for-stable, the
last one.  The first two are not marked as-such.  However, when picking
up just the patch 3, I'm seeing iotest failures, for example:

# running qcow2 140
not ok qcow2 140
--- /build/qemu/10.0/tests/qemu-iotests/140.out
+++ /tmp/q10/scratch/qcow2-file-140/140.out.bad
@@ -11,6 +11,7 @@
  { 'execute': 'nbd-server-add',
         'arguments': { 'device': 'drv' }}
  {"return": {}}
+Pattern verification failed at offset 0, 65536 bytes
  read 65536/65536 bytes at offset 0
  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  { 'execute': 'eject',

(it's always "Pattern verification failed").

but when applying all 3, the failures goes away.

I'm picking up all 3.  Please let me know if I should not  :)

Thanks,

/mjt

