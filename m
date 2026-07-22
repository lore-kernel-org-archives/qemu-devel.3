Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A873C4452B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmLM0-0007xX-F8; Tue, 21 Jul 2026 21:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wmLLz-0007wr-6K
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:02:31 -0400
Received: from flow-a5-smtp.messagingengine.com ([103.168.172.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wmLLx-0002eI-Gu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:02:30 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id E9A041380448;
 Tue, 21 Jul 2026 21:02:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 21:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1784682148; x=1784689348; bh=MqFf9UqNtdYGDyDiQlBKenIovtUr7X4e
 4fjwzsdrwXU=; b=YbWIogLZdzYN0nPv1b0T8+5NeQUq+GNYjWz57ykf+OGVRkhB
 1EDdZVLVAdmXI+mPfzHENUbKJcPb2uAiHuCH5+buXqQvWTKYFHFHHu0cRPkEdDkh
 PyxPQAytyv1k4/3TJhUYGDDpgReKeiFPIrQG4gBB/fp1BTWjNvIOB78xUZW9f4uR
 kupx9XC31Y6e8w95TlfV4U7x9bneIQtfFaiqt7zzcP/SmLC2KX34k7HlXSAwJRQu
 lzLq+dbL5L9ft0cq2s3kWCg3hPRWIEUIT5rJx0Q/Zfy+CRpK6/V/N21P8nFKfe93
 XMSYZKBn9aLcJVigOdkKEJvMEEEv5XTNMYHjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784682148; x=
 1784689348; bh=MqFf9UqNtdYGDyDiQlBKenIovtUr7X4e4fjwzsdrwXU=; b=S
 rBY4ajopkkgcvaWzTwnBK+fzgXaA9dRl3qkQ1rCZM6MaQSIf+6hHd2IFjYL3d34b
 +4nXn9FXlCiTGPthxBrzotgRb7D7Z2d+jvOKBuSXbNh2T9cXnHECAjbCVNgH2dPP
 84LEg29hNgmtHUku2P/iuPwrQ+ZVu7dVpsGc+5oVvMAh+7nne89V/rdEOhGjHL/n
 0DzGCBjMf4FYJKtI7oS5nKeaXrgGqlYOX95HNh4D2QnoMulB93Cblg7/x0L4g+Ry
 +611d2n8PBheeaZhQT8h1L9YNKJgM2ur2Jz/OIbeANlgBt/Pd3fiMHgUQE7PFUP6
 DM7si5XFWWgdF/8cBeCJw==
X-ME-Sender: <xms:pBZgauOavA24DqzdufYN-n9ADw8VWXdstGAHf7pIL_X1ucr-QwiHuQ>
 <xme:pBZgatFlS_pd0d8jJIs3XrFib8eom9V9PBdhnQt0BM1ela9gJVIOOcj7mabeIh-S6
 TM9-wfabz_A25g309SOMLsydAUBccr5u3_12opR5lRvX6-67NLVovI>
X-ME-Received: <xmr:pBZgatMpE9gQIco6BUPrE0ojPJZsh7Q0ImGJv7s4-_LoBIuoPCQYNN2Syu7zw5nKdoh1DQJPxYvyJKB-t5SpJeD7z6mdaefO62gltxZ4V8AHEMWHH8Cs>
X-ME-Proxy-Cause: dmFkZTFyP7GCkvP8MNqMMZwis0FWUND97Atr/8koFpR3MKCRvfF32wjg2WMObT7UjXhVV9
 nP5chsEYOEUmdTWRq+RgNJ2mw9FJxBkTK4WuwoxVJxp+tqXNG01ZC9flLZiUd+TqyN4a8K
 PUu2WSrVNCVcKQJk35vcyd9EJW3pjhh9P5/+ECU0G8iOSEJxhIG3hLQuQi7Tx/RGdtg3cN
 atJ3nHDbrBD0+14Ns8E6xQg/KjtepeEFyhZqYXVZE3Is3A4gcRdiW8mHrGyOxRCQP/yJFL
 nOtTPRj46tZk5eVgBCrRRKFmaqGjUl3lIzWr2YZ1QgWv5YgFYjmNC1VRSyDhydZ3VRkRWx
 F7Ji3gBjtReByzcjqe6BCw0w9waY4K7yKNgQqnBThpQu3bwXkoW2qjKTPdaSkP2fVukcJJ
 mlchHQvAyUqij1Vu+hzmBjO5z6FMAlu+NKoaVFQZTBJ22OGYrvsXAhoA3ffCXWRoohuCHK
 p/g7vokBUgHDpeXHYD8e7Q4XvYRWRhDiPnznMcvb7zDVfctYkNcqmEJnPUaAdbXFS28gZk
 5/ILjp+A5Q9JRFaoyAA9/IFjc/E84N7OOyXOsu+8DbkXOrDuQshdryfTfntPJgSfx81mS0
 nbg5AhRvE65WgxpmD5aT5JwcMGvKfcPaFEkBFT/IUuOxpGZAgCVW26SIw/Qw
X-ME-Proxy: <xmx:pBZgam8hbyPOBuqvwcLzFqO-XXi4ifzdampu_TvtTE7xLbr-1zw4Qg>
 <xmx:pBZgahQEmXDefNtxfFVryroemA2uxHxc5XI5of9lxX-VK_Om24JGQw>
 <xmx:pBZgaonCYF6Jz1qu_TGW_jevZM49DMJkRew5jOmj06EfqGIBwPJQPQ>
 <xmx:pBZgahQgh--s-T38Idsp0FcGqfpCBpqOAMQPn_hcY_rEHQ92sI7X2w>
 <xmx:pBZgap3zR3qWvV0d9lylMHNp7A91BaeFiigHL5uxzDcBcrZQGonodhag>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 21:02:28 -0400 (EDT)
Message-ID: <b44f3d637af2df4cb89cfd3fcfd89be116dcf414.camel@alistair23.me>
Subject: Re: [PATCH] hw/net/xilinx_axienet: Don't write checksums off end of
 packet
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang
 <jasowangio@gmail.com>
Date: Wed, 22 Jul 2026 11:02:28 +1000
In-Reply-To: <20260706162704.787495-1-peter.maydell@linaro.org>
References: <20260706162704.787495-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.140;
 envelope-from=alistair@alistair23.me; helo=flow-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDE3OjI3ICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOgo+
IFRoZSB4aWxpbnhfYXhpZW5ldCBkZXZpY2UgaGFzIGV0aGVybmV0IGNoZWNrc3VtIG9mZmxvYWRp
bmcsIHdpdGggYQo+IG1vZGUgd2hlcmUgdGhlIGd1ZXN0IHByb3ZpZGVzIHRoZSBvZmZzZXRzIHdp
dGhpbiB0aGUgcGFja2V0IHdoZXJlCj4gdGhlIGRhdGEgdG8gYmUgY2hlY2tzdW1tZWQgc3RhcnRz
LCBhbmQgd2hlcmUgdGhlIGZpbmFsIGNoZWNrc3VtCj4gc2hvdWxkIGJlIHdyaXR0ZW4gaW50byB0
aGUgcGFja2V0Lgo+IAo+IFdlIGRvbid0IHNhbml0eSBjaGVjayB0aGUgVFhfQ1NJTlNFUlQgb2Zm
c2V0IGJlZm9yZSB3cml0aW5nIHRoZQo+IGNoZWNrc3VtIGRhdGEgaW50byBpdCwgd2hpY2ggbWVh
bnMgdGhlIGd1ZXN0IGNhbiBwYXNzIHVzIGEgdmFsdWUgdGhhdAo+IGlzIGxhcmdlciB0aGFuIHRo
ZSBwYWNrZXQgaXRzZWxmIGFuZCBjYXVzZSB1cyB0byB3cml0ZSB0aGUgY2hlY2tzdW0KPiBvZmYg
dGhlIGVuZCBvZiB0aGUgYnVmZmVyLsKgIFdlIGFsc28gZG9uJ3QgZXhwbGljaXRseSBjaGVjayB0
aGUKPiBUWF9DU0JFR0lOIG9mZnNldDsgdGhpcyBkb2Vzbid0IGN1cnJlbnRseSBjYXVzZSBhbnkg
cHJvYmxlbXMgYmVjYXVzZQo+IHdlIHdpbGwgcGFzcyBhIG5lZ2F0aXZlIGxlbmd0aCB0byBuZXRf
Y2hlY2tzdW1fYWRkKCkgd2hpY2ggZG9lcwo+IG5vdGhpbmcsIGJ1dCBpdCdzIGEgcG90ZW50aWFs
IHRyYXAgZm9yIHRoZSBmdXR1cmUgaWYgdGhlIHR5cGUKPiB1c2VkIGZvciB0aGUgbGVuZ3RoIGdl
dHMgY2hhbmdlZCB0byBiZSB1bnNpZ25lZC4KPiAKPiBFeHBsaWNpdGx5IGNoZWNrIHRoZSBvZmZz
ZXRzLsKgIFRoZSBkYXRhc2hlZXQgZG9lc24ndCBzYXkgd2hhdCBoYXBwZW5zCj4gaWYgdGhlIGd1
ZXN0IG1pc3Byb2dyYW1zIHRoaXMsIHNvIHdlIGNob29zZSB0byBsb2cgYW4gZXJyb3IgYW5kIHNl
bmQKPiB0aGUgcGFja2V0IGFzLWlzLgo+IAo+IENjOiBxZW11LXN0YWJsZUBub25nbnUub3JnCj4g
UmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRl
bXMvMzU5OQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lz
QHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L25ldC94aWxpbnhfYXhpZW5ldC5jIHwg
MjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3hp
bGlueF9heGllbmV0LmMgYi9ody9uZXQveGlsaW54X2F4aWVuZXQuYwo+IGluZGV4IDk3MDczMmIx
NjIuLmE0NGRkYTUzODUgMTAwNjQ0Cj4gLS0tIGEvaHcvbmV0L3hpbGlueF9heGllbmV0LmMKPiAr
KysgYi9ody9uZXQveGlsaW54X2F4aWVuZXQuYwo+IEBAIC05MTksMjAgKzkxOSwyNyBAQCB4aWxp
bnhfYXhpZW5ldF9kYXRhX3N0cmVhbV9wdXNoKFN0cmVhbVNpbmsKPiAqb2JqLCB1aW50OF90ICpi
dWYsIHNpemVfdCBzaXplLAo+IMKgwqDCoMKgIGlmIChzLT5oZHJbMF0gJiAxKSB7Cj4gwqDCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgc3RhcnRfb2ZmID0gcy0+aGRyWzFdID4+IDE2Owo+IMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHdyaXRlX29mZiA9IHMtPmhkclsxXSAmIDB4ZmZm
ZjsKPiAtwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgdG1wX2NzdW07Cj4gLcKgwqDCoMKgwqDCoMKg
IHVpbnQxNl90IGNzdW07Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgdG1wX2NzdW0gPSBuZXRfY2hl
Y2tzdW1fYWRkKHMtPnR4cG9zIC0gc3RhcnRfb2ZmLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZiArIHN0
YXJ0X29mZik7Cj4gLcKgwqDCoMKgwqDCoMKgIC8qIEFjY3VtdWxhdGUgdGhlIHNlZWQuwqAgKi8K
PiAtwqDCoMKgwqDCoMKgwqAgdG1wX2NzdW0gKz0gcy0+aGRyWzJdICYgMHhmZmZmOwo+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoc3RhcnRfb2ZmID4gcy0+dHhwb3MgfHwgd3JpdGVfb2ZmICsgMiA+IHMt
PnR4cG9zKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9sb2dfbWFzayhMT0dfR1VF
U1RfRVJST1IsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICIlczogb2Zmc2V0cyBvdXRzaWRlIHBhY2tldCwgc2tpcHBpbmcKPiBjaGVja3N1bVxu
IiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
VFlQRV9YSUxJTlhfQVhJX0VORVQpOwo+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHRtcF9jc3VtOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVpbnQxNl90IGNzdW07Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgLyogRm9sZCB0aGUg
MzJiaXQgcGFydGlhbCBjaGVja3N1bS7CoCAqLwo+IC3CoMKgwqDCoMKgwqDCoCBjc3VtID0gbmV0
X2NoZWNrc3VtX2ZpbmlzaCh0bXBfY3N1bSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1w
X2NzdW0gPSBuZXRfY2hlY2tzdW1fYWRkKHMtPnR4cG9zIC0gc3RhcnRfb2ZmLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnVmICsgc3RhcnRfb2ZmKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBBY2N1bXVsYXRlIHRoZSBzZWVkLsKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dG1wX2NzdW0gKz0gcy0+aGRyWzJdICYgMHhmZmZmOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgIC8q
IFdyaXRlYmFjay7CoCAqLwo+IC3CoMKgwqDCoMKgwqDCoCBidWZbd3JpdGVfb2ZmXSA9IGNzdW0g
Pj4gODsKPiAtwqDCoMKgwqDCoMKgwqAgYnVmW3dyaXRlX29mZiArIDFdID0gY3N1bSAmIDB4ZmY7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRm9sZCB0aGUgMzJiaXQgcGFydGlhbCBjaGVj
a3N1bS7CoCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNzdW0gPSBuZXRfY2hlY2tzdW1f
ZmluaXNoKHRtcF9jc3VtKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogV3JpdGVi
YWNrLsKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmW3dyaXRlX29mZl0gPSBjc3Vt
ID4+IDg7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmW3dyaXRlX29mZiArIDFdID0gY3N1
bSAmIDB4ZmY7Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDC
oCBxZW11X3NlbmRfcGFja2V0KHFlbXVfZ2V0X3F1ZXVlKHMtPm5pYyksIGJ1Ziwgcy0+dHhwb3Mp
Owo=


