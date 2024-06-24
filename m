Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702A8C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLf4h-0003eL-MF; Mon, 24 Jun 2024 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1sLf4g-0003ds-BR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:29:18 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1sLf4Y-00046f-Hc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=lZ+TuCC4QLK9snqTwfZVWU5orHHK6FkfVdhZXe/sn2U=; b=U
 H5m0ZCLxkyD/FM1mRGEcMvFNjBPzkYEjHlu8AvORhHQEE/RkbpDpvaQcbNZuDB/k
 a1irI9t7Lt5rCcqWnjkudOwZPt8yzzWc3FbYTKk3U9KNiwMD+m/qj7PUYZb+hC7J
 vSXu0UY5y4uILE32oRyU/PB7m6aDvzq+qTcT9YVOZM=
Received: from 13824125580$163.com ( [14.125.52.91] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Mon, 24 Jun 2024 16:28:52 +0800
 (CST)
X-Originating-IP: [14.125.52.91]
Date: Mon, 24 Jun 2024 16:28:52 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: Did the "TCG" emulation mode has a full capability compare with the
 "KVM" emulation mode?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aC/6auE8o5CSRZekfm0sQjuY3UcOxvPsk245RO51wjDjpxRAqTERlLFnbyvKtLQmFjT6xTBtQ4+Jcf7RZco4NuDec3Fy0TXwP8TvZ+HXdyQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_134691_91047209.1719217732498"
MIME-Version: 1.0
Message-ID: <62981bf0.8f16.190495cbb92.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wCHfZ9ELnlmmmgDAA--.19332W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiZQ0IQmXAmmBingACsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.4; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_BL=0.01, RCVD_IN_MSPIKE_L4=1.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------=_Part_134691_91047209.1719217732498
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGVsbG8gZm9sa3M6CiAgIEkgaGF2ZSBhIHB1enpsZSBvbiBxZW11IG1ham9yIHR3byBlbXVhdGlv
biBpbXBsZW50aW9ucyBvbiB3aG9sZSBzeXN0ZW0gZW11bGF0aW9uLCB0aGF0IGlzICxleGNlcHQg
dGhlIGVtdWF0aW9uIHNwZWVkLCBkaWQgdGhlIFRDRyB3b3JrIG1vZGUgaGFzIGFueSB3ZWFrbmVz
cyB0aGFuICJLVk0iIHdvcmsgbW9kZSBvbiB3aG9sZSBzeXN0ZW0gZW11bGF0aW9ucyhpbmNsdWRp
bmcga2VybmVrIGFuZCB1c2VyLXNwYWNlKT8gaXMgdGhlcmUgYW55IHdvcmsgdGhhdCBrdm0gY2Fu
IGRvIGJ1dCBUQ0cgY2FudD8gCgoKb2YgY291cnNlIGt2bSBpcyBtdWNoIGZhc3RlciB0aGFuIFRD
RywgYnV0IG15IHF1ZXN0aW9uIGp1c3QgYWJvdXQgdGhlIGZ1bnRpb24sIG5vdCBjYXJlIGFib3V0
IHNwZWVkLgoKCnRoYW5rcyBmb3IgeW91ciBraW5kbHkgaGVscCEKQlJzCnppbG9uZy4=
------=_Part_134691_91047209.1719217732498
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGVsbG8gZm9sa3M6PC9k
aXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7SSBoYXZlIGEgcHV6emxlIG9u
IHFlbXUgbWFqb3IgdHdvIGVtdWF0aW9uIGltcGxlbnRpb25zIG9uIHdob2xlIHN5c3RlbSBlbXVs
YXRpb24sIHRoYXQgaXMgLGV4Y2VwdCB0aGUgZW11YXRpb24gc3BlZWQsIGRpZCB0aGUgVENHIHdv
cmsgbW9kZSBoYXMgYW55IHdlYWtuZXNzIHRoYW4gIktWTSIgd29yayBtb2RlIG9uIHdob2xlIHN5
c3RlbSBlbXVsYXRpb25zKGluY2x1ZGluZyBrZXJuZWsgYW5kIHVzZXItc3BhY2UpPyBpcyB0aGVy
ZSBhbnkgd29yayB0aGF0IGt2bSBjYW4gZG8gYnV0IFRDRyBjYW50PyZuYnNwOzwvZGl2PjxkaXYg
c3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+b2YgY291
cnNlIGt2bSBpcyBtdWNoIGZhc3RlciB0aGFuIFRDRywgYnV0IG15IHF1ZXN0aW9uIGp1c3QgYWJv
dXQgdGhlIGZ1bnRpb24sIG5vdCBjYXJlIGFib3V0IHNwZWVkLjwvZGl2PjxkaXYgc3R5bGU9Im1h
cmdpbjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+dGhhbmtzIGZvciB5b3Vy
IGtpbmRseSBoZWxwITwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+QlJzPC9kaXY+PGRpdiBz
dHlsZT0ibWFyZ2luOjA7Ij56aWxvbmcuPC9kaXY+PC9kaXY+
------=_Part_134691_91047209.1719217732498--


