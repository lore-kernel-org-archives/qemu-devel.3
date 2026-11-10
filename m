Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B19606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jablonski.xyz header.i=@jablonski.xyz header.a=rsa-sha256 header.s=fm2 header.b=glG3HQTS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RonVt5dS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQeE2-0007b9-Ey; Tue, 10 Nov 2026 00:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1xQeE0-0007Xk-0j
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 00:16:52 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1xQeDx-0001xp-Vf
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 00:16:51 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 8E1C31D00097
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 00:16:47 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 00:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794287807; x=
 1794374207; bh=q3weXhJXGwjGYoWg2XwCEzxZOvGip+LSoIHMNBiP/PA=; b=g
 lG3HQTS+m5rhZEi43NpIpifocT7z3i3YdHnAUpmHvbAps3ZU8h6lhM/a+lGxiJ0i
 krOKQFLv55A5B6U+6x756xkN+D0KMLL5QSNfuwc5AxFUZcy26rSlkeYptcLhPzC9
 msSp7PhpJfnw8OUsNv9RpDbRb7emRFbiwLC6Jkv9WbpttECLuFDgTFmhYOIYhL1P
 SLuTDXVWiYgfph3bx7d2ZzBBrh/EdkDywfuLne0/qiKABopYy5GhHUwwEw20WujV
 AQEx8t+l3xWAp1tLyrOq2iHlJrj0Tfet89ypEkfc7c+qkskjVlAbWwH0q923Ityt
 xKw/Bdd1dryERR0GDNlsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794287807; x=1794374207; bh=q3weXhJXGwjGYoWg2XwCEzxZOvGi
 p+LSoIHMNBiP/PA=; b=RonVt5dS5FvnZlGUByBrYK7xBOSNri46EZErswLNVy4c
 9tZa+epjAeNHDOb7XZeC3iciPPKauNH+H3pR5QDl2CCm33ufb6tpSXwfA2wVYTbx
 fVreX7pXAzzxrr3hJoDFa+pFJFcRgTiUXz0hngYzEOwU7MAIq6gny6lrRdGjGRrm
 Lkw+1o4KT2KgRLceGODLS8gf05AnR3TwzBg8qqId6tTWEkghKYSqx0v/aYueGanr
 HYE3DM+04Npy5M2lajaHicPg0r1TLss1CAcxB3GcSGdZpivzcCHfHmwrg/6YE2dx
 Hb3m+HgibkHyENGxdodD0zMSVL5T6uHLIeFtvzTDEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jablonski.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794287807; d=jablonski.xyz;
 mf=PGNoYWRAamFibG9uc2tpLnh5ej4=;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:NNlG7E81xRUzpsNMA73yhiMSwmWyI9LFUUUpX2/tPjxsZcr
 x1pljwePtHvL16i1o6wTXjKKE4kQ0CUTzRyEQtld0EjFrcLzHtvtdGAMzpLqfq0E
 sDPi01QkWMRjntB0R5nAAj5iV1VD72lyOzGJ2PbEYXtdKHg6DA09wxM6UZTpLz6K
 fVdsfrrCmfamPM7MFqQqGQOxYSlkFBq4KzPM+qvMxGgZfAEdRPlDX86ap45Qp3kD
 rFmT/sYhfL0X5omiGhDIvL8s3ok5lCdPfYQSR2uW3OFqydemR1gev+f8i4KTGmtI
 pXwIB/j/iuZSZ9kpm49dCidesgMz4IH9KOE/e2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:tr+B9Dz9rKBZ5ae2U+auSTyd+fQJJERRHKHJoKzyMX0=:q3weXhJXGwjGYoWg2XwCEzxZOvGip+LSoIHMNBiP/PA=;
X-ME-Sender: <xms:vqjyap8e31jr_GNQd0JgEtCsa7G99U7OfbjKaUEJWcEwJP8YPm12sw>
 <xme:vqjyaoi3pUT5IMct_OsAL8Ktr5_65gI-jLc9wUGcKmlp5fG94LRbwgbe7QLUM9D0M
 YzeT2pAlV56iDkgodLBSrxi5hUaIxnvm29SZM6WUqkmP7KKn2f-3M8>
X-ME-Proxy-Cause: dmFkZTF83S9nMk8EK5NonNUhBPyW9VeBCrf5DiJdTpGLoSa18PDYS8pVDC03H1b0YPKRKS
 ZccXOUN6cM54SMZwx+7s8Z1RzYZIjOheUWQBfiMO62ViCMOaVRSTXGro54zRjZn1BsM/NL
 htkS53bEG+Hr5nPOacNNsUbsKBTwtux1ev5FVbopbIc1kRntRPPALILtlB8hrlkKJ7oLWW
 NSYEq2/sx2qztR2Y18gdecgXgnWoorf7sDIYshC8tmF51ZgCDmyR9yVW6R/l0+WHASRRYS
 axB3TE8lfImhmP2WgYVM0IpXzJQbe8Q2JrK5pRtoJhLPZJ6oWlb1XdCJPO16f45JoAq2M0
 CTqOIyFPPnFFqgdcmkaHdzk7H3f/OgVR0SlseWkIgHayzUz5icIs5/6uxgfLgDXvvQAb3s
 7prYpnL7IQ309cteqEVzde1FW9gsPdyUE5kTTpHp4gdGDbIiaA+oez+RxxSDny7Hfb1Z2I
 6zC09utbaHZAV+RDrnjyr9eZ7cl4/EcXVY9oh8sxVMYFGN6hLd1BG9a1DphUWcFEA12hUw
 gtSTi7Ai39k2bx00FKTahBwcdQRBAaLSYOvafWq6l8ks6s3MaDF5LwYKWsKHc+Yq2of+vc
 puTk2jBTp32BHJm6b3ZMAmpsvLR2gEwEHbUNh3OMtLp5JFaJs7RLAFYxRZug
X-ME-Proxy: <xmx:vqjyaoprOsoBHrZjkveUzaEL-vIIGnKeT_PTCSV-ogxbiEj0KTi8cw>
 <xmx:vqjyaskOkI6fZ6Jo52aylvFMMmVgxd2tLtjUWJzu7XZJmOSjB5W7aw>
 <xmx:vqjyakxfsflTJ4u91jbKB6gO4kzFDPFXm8DoYqBVYYjjCYgEBNVZKg>
 <xmx:vqjyasnGywsRjxf_kTI8ycYXqNRhgHnmstqEiGXgMe_eKxn-ABjXbQ>
 <xmx:v6jyaleCqHWGeVRYKNLYdANN2QauwMDHlMEmlfs7CdXLkzosMZn1Bjbx>
Feedback-ID: ib26944c1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C88AF700065; Tue, 10 Nov 2026 00:16:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 00:16:26 -0500
From: "Chad Jablonski" <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: "BALATON Zoltan" <balaton@eik.bme.hu>
Message-Id: <ba243055-55f7-45e7-a02e-e146f0b89323@app.fastmail.com>
Subject: CCE/CP/PM4 Microengine Microcode for ati-vga
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ati-vga device does not currently implement the CCE/CP/PM4 microengine.
This is a small packet processor that reads command packets from a ring buffer
and turns them into a series of register writes. Many drivers require this
but at the moment we're limited to MMIO.

The processor requires drivers to load a small microcode on initialization but
it has been an open question as to how this microcode works. I've been doing
some work to understand it. It's still a work in progress with a lot of
unknowns, but I thought it would be worth posting what I've learned at this
point:

https://chad.jablonski.xyz/r100-microcode.html

The short story is that the microcode is a horizontal microcode. I go into a lot
more detail in the writeup. There's also a full listing of the partially
disassembled stock microcode at the end. I've found it easiest to view as a
table.

The source for this and some cli tools for (dis)assembling the microcode
live here: https://codeberg.org/cjab/ati-tests/src/branch/main/microcode

Also, thanks to Zoltan, a summary of the previous discussions around this lives
here: https://codeberg.org/qmiga/pages/issues/3

I currently have a series in flight implementing the r100 CP engine:
https://lore.kernel.org/qemu-devel/20260719161536.774061-1-chad@jablonski.xyz/

It takes the approach of implementing the packet handlers in C. I'm deciding
between that approach and implementing an interpreter for the microcode. Either
way the RE work should be helpful.

Chad Jablonski
chad@jablonski.xyz

