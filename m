Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A5DC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 09:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQkVE-0001Vq-5P; Mon, 08 Jul 2024 05:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1sQkUl-0001Qx-VP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:17:19 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1sQkUi-0003jT-Tw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=9BE3M36HCQfzhr2eyakQOuAMQxsub9eO4TT0TRw7AYc=; b=S
 lZ+sZzI4m1tDpdrRyWTd0QPUpMdp0+24VLRJF2jnGlGfm43JN4PI+1H1MAlqzMWn
 6OjuPol1VSOhTi0QdsCbIDqh/sIaOzioe7syp6zVxAg5tQjA2wZ5fQZsbA3WswOe
 x1QXK6J3+K+CPvRvnELJ8/kDdXakbscyz1IgnpPdVI=
Received: from 13824125580$163.com ( [14.125.52.22] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Mon, 8 Jul 2024 17:16:57 +0800 (CST)
X-Originating-IP: [14.125.52.22]
Date: Mon, 8 Jul 2024 17:16:57 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: Now, Can  the Device That Pass-through to The Guest Linux OS use
 "iommu" again to map its own device iova?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZAviYv0oq4SSbZ+kfmk0UgOs5WcS2vPUm24ReO5FwjAnp9Ck7eVVGEGbP3OKFCR+zvR2STilHzOlhfIdDQpMkgV+pLVyYJbFld991ocH0ag==
Content-Type: multipart/alternative; 
 boundary="----=_Part_145003_1350236499.1720430217436"
MIME-Version: 1.0
Message-ID: <8d59f81.9999.19091a1c8dc.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3P5qJrotm08ElAA--.45671W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiZR8WQmXAm5f6vwADsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.2; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L4=0.001, SPF_HELO_NONE=0.001,
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

------=_Part_145003_1350236499.1720430217436
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGVsbG8gZm9sa3M6CiAgb24gZGV2aWNlIHBhc3MtdGhyb3VnaCBzY2VuYXJpb3MsIGEgZGV2aWNl
IGNhbiBiZSBwYXNzLXRocm91ZWQgdGhyb3VkIGlvbW11IGJ5IG1ha2luZyBhIGR1cGxpY2F0ZSBw
YWdlIHRhYmxlIChJT1ZBLCBIUEEpIHdpdGggdGhlIFZDUFUgbWFwKEdQQSxIUEEpLCBidXQgdGhl
IGRldmljZSBpbiB0aGUgZ3Vlc3Qgb3MgY2FudCB1c2VkIGlvbW11IGFnYWluCnRvIG1ha2UgaXRz
IG93biBtYXAgbGlrZSBpbiBIT1NUIE9TLiB0aGF0IGNhbiBiZSBjYWN1bGF0ZWQgdGhyb3VnaCB0
d28gd2F5czoKMS4gZG1lc2d8Z3JlcCAtaSBpb21tdQoyLiBwcmludGsgdGhlIHN0cnVjdCBidXN5
X3R5cGUtPmlvbW11X29wcy4Kd2hpY2ggdGhlIGZpcnN0IG9uZSBzaG93cyB0aGUgaW9tbXUgY2Fu
dCBvcGVuIGluIHZtLiBhbmQgdGhlIGxhdGVyIHNob3dzIHRoZXJlIGFyZSBubyBpb21tdSBvcHMg
YmluZ2RpbmcgdG8gZGV2aWNlIGRyaXZlci4KCgpTbywgaXMgdGhpcyB0aGUgZ2VuZXJhbCBjYXNl
IG9uIHByZXNlbnQgZGV2aWNlIHZpcnR1YWxpemF0aW9uPyBpZiBzbyAsIGRpZCB0aGlzIG1lYW5z
IGFsdGhvdWcgd2UgY2FuIGRvIGEgbmVzdCB2aXJ0dWFsbGl6YXRpb24gb24gQ1BVLCBidXQgd2Ug
c3RpbGwgY2FudCBkbyB0aGUgZGV2aWNlIG5lc3QgdmlydHVhbHphdGlvbiBwcmVzZW50PyAgdGhh
bmsgeW91ciB5b3VyIGtpbmRseSBoZWxwLgoKCkJScwp6bGNhby4=
------=_Part_145003_1350236499.1720430217436
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGVsbG8gZm9sa3M6PC9k
aXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgb24gZGV2aWNlIHBhc3MtdGhyb3VnaCBz
Y2VuYXJpb3MsIGEgZGV2aWNlIGNhbiBiZSBwYXNzLXRocm91ZWQgdGhyb3VkIGlvbW11IGJ5IG1h
a2luZyBhIGR1cGxpY2F0ZSBwYWdlIHRhYmxlIChJT1ZBLCBIUEEpIHdpdGggdGhlIFZDUFUgbWFw
KEdQQSxIUEEpLCBidXQgdGhlIGRldmljZSBpbiB0aGUgZ3Vlc3Qgb3MgY2FudCB1c2VkIGlvbW11
IGFnYWluPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij50byBtYWtlIGl0cyBvd24gbWFwIGxp
a2UgaW4gSE9TVCBPUy4gdGhhdCBjYW4gYmUgY2FjdWxhdGVkIHRocm91Z2ggdHdvIHdheXM6PC9k
aXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4xLiBkbWVzZ3xncmVwIC1pIGlvbW11PC9kaXY+PGRp
diBzdHlsZT0ibWFyZ2luOjA7Ij4yLiBwcmludGsgdGhlIHN0cnVjdCBidXN5X3R5cGUtJmd0O2lv
bW11X29wcy48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPndoaWNoIHRoZSBmaXJzdCBvbmUg
c2hvd3MgdGhlIGlvbW11IGNhbnQgb3BlbiBpbiB2bS4gYW5kIHRoZSBsYXRlciBzaG93cyB0aGVy
ZSBhcmUgbm8gaW9tbXUgb3BzIGJpbmdkaW5nIHRvIGRldmljZSBkcml2ZXIuPC9kaXY+PGRpdiBz
dHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5TbywgaXMg
dGhpcyB0aGUgZ2VuZXJhbCBjYXNlIG9uIHByZXNlbnQgZGV2aWNlIHZpcnR1YWxpemF0aW9uPyBp
ZiBzbyAsIGRpZCB0aGlzIG1lYW5zIGFsdGhvdWcgd2UgY2FuIGRvIGEgbmVzdCB2aXJ0dWFsbGl6
YXRpb24gb24gQ1BVLCBidXQgd2Ugc3RpbGwgY2FudCBkbyB0aGUgZGV2aWNlIG5lc3QgdmlydHVh
bHphdGlvbiBwcmVzZW50PyZuYnNwOyB0aGFuayB5b3VyIHlvdXIga2luZGx5IGhlbHAuPC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5C
UnM8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPnpsY2FvLjwvZGl2PjwvZGl2Pg==
------=_Part_145003_1350236499.1720430217436--


