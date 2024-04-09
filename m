Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083BCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8Eg-0004GR-PG; Tue, 09 Apr 2024 05:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1ru8Ed-0004GE-Rk
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:57:47 -0400
Received: from m15.mail.163.com ([45.254.50.219])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1ru8EX-0001I8-Ij
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=86V3DteZjfUFaeozzaoAx6EhbZcthvWVAboW3Ss0HvY=; b=J
 6Le7zp/HGaAEfgmkZ9My3Y6y91pUtjzuqDEidohvGg7q9DgyfUg2Vr2wuJkKU8go
 za+laCPGdDkCNlI9MSaL7vefbS+9ZceMroEuWfitjUgAcSXhbgb8vaWWEgHf6u2X
 Dl/ReZgfIt3l0JpVJBHNIX53ITbRuNFJNfunnKOsjI=
Received: from 13824125580$163.com ( [14.125.55.124] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Tue, 9 Apr 2024 17:57:29 +0800 (CST)
X-Originating-IP: [14.125.55.124]
Date: Tue, 9 Apr 2024 17:57:29 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: how does the qemu emulate the "atomic" semantics on host that DOES
 NOT support atomic instructions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aAPqeuU4v7yiQZekfm0sQjuY3UcOxvPsk245RO51wjDzp5y0+ZXB5AkX26OS0EhiykSKtXhlu5uBRUoBcZIs2pdwGkgDGk7cioor5u0p6eQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_223073_1084803906.1712656649885"
MIME-Version: 1.0
Message-ID: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDX_6sJERVmN4kGAA--.6604W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiYx+zQmV4HeEymwAEsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=45.254.50.219; envelope-from=13824125580@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

------=_Part_223073_1084803906.1712656649885
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CgoKICAgSG93IGRvZXMgdGhlIHFlbXUgZW11bGF0ZSB0aGUgdGFyZ2V0IHRoYXQg
c3VwcG9ydCAiYXRvbWljIiBJU0EsIHN1Y2ggYXMgcmlzY3YgImFtbyIgaW5zdHJ1Y3Rpb24gb24g
aG9zdCBtYWNoaW5lIHRoYXQgZG9lcyBOT1Qgc3VwcG9ydCBhdG9taWMgIGluc3RydWN0aW9ucyA/
CmlzIHRoaXMgc2NlbmFyaW8gaGFwcGVuZHM/CnRoYW5rIHlvdSEKQlJzCnpsY2FvLg==
------=_Part_223073_1084803906.1712656649885
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4m
bmJzcDsgJm5ic3A7SG93IGRvZXMgdGhlIHFlbXUgZW11bGF0ZSB0aGUgdGFyZ2V0IHRoYXQgc3Vw
cG9ydCAiYXRvbWljIiBJU0EsIHN1Y2ggYXMgcmlzY3YgImFtbyIgaW5zdHJ1Y3Rpb24gb24gaG9z
dCBtYWNoaW5lIHRoYXQgZG9lcyBOT1Qgc3VwcG9ydCBhdG9taWMmbmJzcDsgaW5zdHJ1Y3Rpb25z
ID88L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPmlzIHRoaXMgc2NlbmFyaW8gaGFwcGVuZHM/
PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij50aGFuayB5b3UhPC9kaXY+PGRpdiBzdHlsZT0i
bWFyZ2luOjA7Ij5CUnM8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPnpsY2FvLjwvZGl2Pjwv
ZGl2Pg==
------=_Part_223073_1084803906.1712656649885--


