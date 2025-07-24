Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B45C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uewzG-0002QS-DH; Thu, 24 Jul 2025 10:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hk@zapateado.de>) id 1uewz8-0002Ny-O1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:31:50 -0400
Received: from relay.yourmailgateway.de ([188.68.63.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hk@zapateado.de>) id 1uewz6-0005jv-9u
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:31:50 -0400
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4bntjT07bcz614W
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 16:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zapateado.de; s=key2;
 t=1753367485; bh=Wvx5uP/egaSizE6t2Am20PIk6jnCYKRLYH447Ncn1Lc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=MrJG41BpZJIszO0ULEGUY+SvehKCcxW2GUiRunyjDgOMPJ1BYIl0AML+gMu/iSx0t
 D7nVWXqiwgJ4ZQfiuy+DMnsXe9xvXhQjo2gx2I6cjYwiRLAUIR9UTIVAex7L+baT+B
 Y9w1tfkNgOmRiZyGVSKQQmseU40tjVsI+r+X3LTqPidWWhmyl8agJYF/WXarb5G4p7
 PvQErFoaK+bynH/vy3/vYolKK+msXCAIoHUZRO0G3gxaY20Kwo7Tk75hP1P103nFSd
 pv4eXgrApBpcFaegLszGsl8rObwx2CwQ8hWOe90DgLUTeYXIwkQSxZ3wxqmCx96Zpe
 7K6kKzcz0SlKg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4bntjS6Xj5z4y0m
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 16:31:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mx2f6e.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4bntjS2S3yz8t40
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 16:31:24 +0200 (CEST)
Received: from [192.168.54.9] (ip-037-201-193-023.um10.pools.vodafone-ip.de
 [37.201.193.23])
 by mx2f6e.netcup.net (Postfix) with ESMTPSA id 403DF2289E
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 16:31:23 +0200 (CEST)
Authentication-Results: mx2f6e;
 spf=pass (sender IP is 37.201.193.23) smtp.mailfrom=hk@zapateado.de
 smtp.helo=[192.168.54.9]
Received-SPF: pass (mx2f6e: connection is authenticated)
Message-ID: <d45a2008-a8c0-4f49-b8d7-204a1884476b@zapateado.de>
Date: Thu, 24 Jul 2025 16:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] QEMU 10.0.3 Stable released
To: qemu-devel@nongnu.org
References: <1753336684.713829.226974.nullmailer@tls.msk.ru>
Content-Language: en-US
From: Helge Konetzka <hk@zapateado.de>
In-Reply-To: <1753336684.713829.226974.nullmailer@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175336748363.21824.923091850023707609@mx2f6e.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 403DF2289E
X-NC-CID: P6PmLQmFBOCZMH9Ut74waiqfKvc+zwhX5i56+CY0lvT2
Received-SPF: pass client-ip=188.68.63.102; envelope-from=hk@zapateado.de;
 helo=relay.yourmailgateway.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Micheal,

trying to download results in:

curl https://download.qemu.org/qemu-10.0.3.tar.xz
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

Could you have a look?

Best regards
Helge.

