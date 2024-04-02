Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0061C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 05:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrWjy-00025Z-Vz; Tue, 02 Apr 2024 01:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrWjv-00025J-Cs
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 01:31:20 -0400
Received: from jackal.cherry.relay.mailchannels.net ([23.83.223.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrWjs-00072O-S0
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 01:31:18 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 770D2762BD8
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 05:31:14 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 94305762DCA
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 05:31:12 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712035872; a=rsa-sha256;
 cv=pass;
 b=Xf2BBIRNgI4aqosmk9Z/eYuS8J0j1r7HwRB9jt3IP8jaU03cXDvo3MOaPaRkvjRHeYsXpd
 6xDjwmb8IuGLKobPQCfZlXr89t9uIiDWGkyLFEiDjTQjHAnYtCwdbS290rpNHIF1hQddlb
 C7nAm7/7q6yYFGJTQqRO0nErvJg+1XMF1v4SAHQGz4T2D7e5Bef4ZugwSpp75leSBGDHfa
 WhH09g8n/0xxU2rj+SYVrEGQWhnd2uJA2ChgYvT/mkifdwz1+v+1LJ1FD/yIlwqBZNw3OZ
 xTmsvigaDSZMw3MXf9xI0xQDwaYtNq7KC0pr2N5ILFdcq1tfUe4yYWs11PclHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712035872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=WqF/fZkahU9cUyoendMKE9vX2gA3QdPVkk/9+3KSEbs=;
 b=fJqmxPV7ykHRILgymBY1lq+LIY0wWzVHhUhtBIzA5SCpfz2Qd87sgE6Fzqax8+/5b/Qnsa
 NXA8BKVst1dLNBakGo6ZWFTyTDOGx6rATOHXA8PRtjHlRIw4CiiE24wpnXhI4+EuqBmYoQ
 SoDcIwOlKNjCvYLNR2xVBi97CsPqjBoPynKvR1dn6KLI3saMIUUYopNwYks4LjmTK5mQpk
 aSWY9zZPFKpQmsI3aVzSxlTLYA0urVq/Tc8JUtSg3wTUZIojVAjZSE4wctoYM9KB95KaTe
 yXfz5rmYCr4a5O3B7leKSaejiW0g5kgoYjBiNEWhpehvGg4iN4wc6uebCMl2uw==
ARC-Authentication-Results: i=2; rspamd-6457dc597-npskw;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Share-Average: 774ffa3140160bc1_1712035874206_3138980855
X-MC-Loop-Signature: 1712035874206:1727731771
X-MC-Ingress-Time: 1712035874205
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.118.191.224 (trex/6.9.2); Tue, 02 Apr 2024 05:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712035831; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=ciFhVFDsOTS7YRWFxwd8dykbt4S/wciycu0VmeThg1uwQPc7ephClcR2H9DO5NMrhJ/BB1EinH6Tr
 LXm1jLt9yF0x0oqzib7UTmtraxNYbyl3rkqMUjwlVO2FPgHHF39qZD2rN45HVrSWNYFT9iV6a8yLwb
 6Fed6oecuqNRaOBlg9RDqryjdfRQtQgxG5OFL1llzUe1H8Vv7xG6TeZ0Lux+qcFPzxwVHpZNO/KEiq
 B/7J9uStNC+5QCtd/maRE2C1O2wEVzfSIezWWJcDNZCszKoFpmF4SrYLG5phhGxLLz27bGL4Wup7MK
 86UpTI8wLaq+U9EzRxuYaK8Z3eg+bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=WqF/fZkahU9cUyoendMKE9vX2gA3QdPVkk/9+3KSEbs=;
 b=AzcF/V2OTv0pwB1w7xLrmJL6ntxu8ZLVhq6/qMehH+cpAazdHRtjm5Jx7Pb4UuxI0xRgOOUUlZrJ/
 3UBqH4qs/Tw3Gu4IF2zObaqrrrW/0Ercl3tYJ3PGoPndOW41rlqr90kRNkkG1oZEZc9V9KIqX9S5lI
 9Y1MqfEbKCY1nfngPrh9fqJ5DGPtuCFSWSPZU/pOBY6VaWN5/1iRioIzA7abnO/N/0nHzv8PEG4Rw4
 63jR0DeHNEQX3QOJglaXZu6SrSyysQnTlSbNb+N0uGVkR7m/tVmpzPFJ/+o08KV141OOcdE5V4gf0j
 3s6uMu6oRFftVzIiFKjieSxRPS14vtg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=UqQdeOoU; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=WqF/fZkahU9cUyoendMKE9vX2gA3QdPVkk/9+3KSEbs=;
 b=GvmRBNWdzcSOmRlALPiiu5v/f81fBUN7Wex85ZWPnxb0tJDeyYUtX6Yg7Y1foym/BCVleq3VRTm8t
 eayfRIFWx1rc+1tCm4GCuVS2sKvl6zRfNj2O0oUjOVPXPb1raL0dAAlwYCyl1cOoLLea7ecEf4T6Mb
 swhRIUNvEr8FI1xg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=WqF/fZkahU9cUyoendMKE9vX2gA3QdPVkk/9+3KSEbs=;
 b=I+6K7A+MPh3t9mNSCqhcxSGE11930VHR9w8sP/OSAIA67aQrhhhFxNSRNHZdUrUVcEbrLVSqrR3xH
 KEdmuGYv3qhAS7KWvIFQDYd5YOOZ0aJjNs/F1GEhzJmHo78GNaFIskqfoBUWwEpl5Z+4o7uHochHj5
 I/BJ/lPZYMgwScw0NX3zeEjTok7Zn+Aca/KqY/NIuOQgvEUnGUNYw7DkTUiAEz8x44PRNdcQaLleTY
 tZwt68AqSDIbegwZ3qzKBsVWpfDXpuuE1LTq+7PAVa/BetkzlE4qVRcXXA25RWc5yIyIgIXWnGfjpd
 vbk2fvDvxs8u/gJ5Octc8AYKs1LtPdA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 1d998c31-f0b2-11ee-b34b-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 1d998c31-f0b2-11ee-b34b-eda7e384987e;
 Tue, 02 Apr 2024 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WqF/fZkahU9cUyoendMKE9vX2gA3QdPVkk/9+3KSEbs=; b=UqQdeOoUB1ZMkMydYeUuiB/D1Z
 ASaVAwr5JTAb6CfHZN2iR/1TCYBfLNR1J+MAByFTO8ZKcVPaU/a0eFqqIWM7AH+Wd9JKp185OtW9p
 pRjaUHf2/0pbl6wo2pAk0pwiNV/zOgfu306OCJUDHS/pXj0RKrRzrNIjQuLasnvYA4F4EoL8DTWXx
 9vDhxk7w9pG57FwDVqnXiGNMbRF46QXSbEpBHbLTMaqoDABuKv73hc4CwzZkD6GkpCd3YI6/0Hl9L
 ePF2PRiME9868Z086g/Yg0gm3mZdjDaELMMA+4WsUc6wp9jELz16wzG4JAifCCw7J3gPx9wiUY5aR
 SmbMMJ1A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrWjk-0079k6-23;
 Tue, 02 Apr 2024 07:31:08 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/hppa: Fix IIAOQ, IIASQ for pa2.0
In-Reply-To: <20240402012504.177097-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 1 Apr 2024 15:25:04 -1000")
References: <20240402012504.177097-1-richard.henderson@linaro.org>
Date: Tue, 02 Apr 2024 07:31:07 +0200
Message-ID: <875xx0z5yc.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.95; envelope-from=svens@stackframe.org;
 helo=jackal.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The contents of IIAOQ depend on PSW_W.
> Follow the text in "Interruption Instruction Address Queues",
> pages 2-13 through 2-15.
>
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Fixes: b10700d826c ("target/hppa: Update IIAOQ, IIASQ for pa2.0")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Sven, I looked again through IIAOQ documentation and it does seem
> like some of the bits are wrong, both on interrupt delivery and RFI.

Yes, this fixes my issues, thanks!

Tested-by: Sven Schnelle <svens@stackframe.org>

