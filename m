Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB0C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBRH-0002L0-Tf; Wed, 12 Aug 2026 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBQ9-00019K-Vy; Wed, 12 Aug 2026 12:03:17 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBQ7-0000WZ-R2; Wed, 12 Aug 2026 12:03:13 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id B71D9EC0249;
 Wed, 12 Aug 2026 12:03:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 12:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786550589; x=1786636989; bh=vWMzfEhFXcpeWKq4KoS/WtO+SftT/Qe0
 3PScS2Ig1O4=; b=f0jbXldNNySlmEhwf9f/huMizDzS3c8oHC9pVm2bJm8Qq9q2
 zqXy/fXDmWcHJPNq2MSJHntKcEAnKrECfFvBNhQW1tIvH4rqG+fyAH4GB9ZnZhAZ
 AxBuuImbCgTDA1qvzdb9jw+n/n8GEaAo+ELZYQmota3WbplXVSS5w9jwDDKUs6L0
 REYLCjiJ9ap/XzMifDzCaZmus4gbuPZV0H99cj6UGL5XH8pFwCzBoGkn8VQBdzwG
 VUu1fQbE2ETk0GBzOwBorfVgp4hy4YpJ7cNRb8AbqQIpMbYxpwwBtVWTMmXwoYRC
 71Z5f9LIFhhcb193ZfvnwT13a0qTDq1yiPnsWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786550589; x=
 1786636989; bh=vWMzfEhFXcpeWKq4KoS/WtO+SftT/Qe03PScS2Ig1O4=; b=Z
 IF4+XXQHIM6mgLsYIsGRBPIaxVIHpsYVXOZqNHSqtg8fCVadPpcX4TNDXFq2losr
 Jfhpv07qJwFYY6rAHQpcN6rSaNNxvrModhWivFbBKG3Eq5DlZTS6iCs58lRXioxO
 q6GPtZvFahmUSIFHXMwqeQJB0DryZo8/Y9gx8EpC3A9bjqN1/AHGOae7022oky/4
 1PsCaqG7tbtYkW9K3ZVxiHfI4j+wWRRgL9TcnuKqmQuj06XRnvnSOXSYpWSTd4yI
 1nzlPCR61ko0UNTHp5JQgA5IypJnqfLAffhJMtmZ2QauAv8HeBwwmaaRcLHhTuPV
 Mk59j8mlTuHIWFL9ca/xw==
X-ME-Sender: <xms:PZl8akxTyy4izxNPCfdW-UqdrGlf54exm8BYkp75Z5NxQpLgNmOeAQ>
 <xme:PZl8ahkvZi_y3Zg2UkrOwLcUdOyVOxDSrZ2ofzYPW6bR5P7EgvtjIbYNnzEQo5LiJ
 SpBDNmGHS4mgf09HYuvWrp3SPsiErjjVaqqu16Ekww8jfK7p-oMrwk>
X-ME-Received: <xmr:PZl8atlSVHwoBJoEiSEnn7WIgkWej-c6x9VhJn--XxBQqDOQJHvoNhwjAUx05gJ-J1qnOQ>
X-ME-Proxy-Cause: dmFkZTFd+Naju94P4S5rjiAlo/KWXFfynHNF+h6C77wsZE0S+/9TRI+idUiNEiC7r8bkS4
 L6InKFFJPdOgaUobaz0fKh5r3KILhbxc2zyaZVRNB2F69tM2xPE5uMqPHeWznfxCOI1cto
 LoQzgTJKsxmI2x0w1LZJwQV98ZqORwsZxPIImuSF/ra4YWgwFHhYiDwrcAI0FLe2SCjaa4
 cQp3SJbyaad3NGVsQ1fpQH+OuIKLdP/XE4DHlFnfr2rOprWcAe5gAKzNGlDN4UoPXmPYRl
 9JuFedyOI3ITbzpJ63AdmFV1aOI7qTligWThsK++4SYrSnKv2f+MErSYaUbrIrvb29Oekt
 COeiTmLbRoT0Qo4Y/jAKDwiG/zTuKteHTp7s8eQWZw1Ff/ycvLDDDLZ5DpOmfk3r4wPQ90
 R6yNRiMQC4yiEw2AvRpmVl2CLOIRdHptOn7iD861qtmpHTDQn4HsOTf/PQ/IJoH/zi1kpE
 Bat6XVrjPmYLRZdbv2KvFmwWDZvoTiAkSu8u6+m9/e7attY5Gtqze6t17ED6+2p2NJv0qY
 7fWO4ySJVR4RT1e4mPPUWZVF5fsZPGAB2t8hOUpVl7kfqb2JKY+6OyHHh45CUSXzBANiry
 yXmSXeFykIf6QSIIuoM5r9xOitsQ9/88iUtyaH/ZVp1CCBm4aH4o6VmkjarQ
X-ME-Proxy: <xmx:PZl8ajxbks--HX8d1rAoMsiYEUYD-6ARb6AvAOPh8JTRsyeMlawtqg>
 <xmx:PZl8aio3oRAbG9fSgb97WmpBgL_YGHWmNBPWRrUfkqThSlKGyVJhVA>
 <xmx:PZl8ai49ujF4DKV9_Jg79G7iYbu3KuLduQUQYFTGXOkU1-5G-9Bkyg>
 <xmx:PZl8apc877TYfThGGrrMgaPxsvphi23Mgf1BsyAY8ZcRhS0sB7pbCg>
 <xmx:PZl8apfNegBHbx1ZVVivDXHdmFXzpj7wAzomTAjTaS4PVDdhY_Kn2aC2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:03:08 -0400 (EDT)
Message-ID: <5f0550a38a1c6b614d7647d173d763f3d36f59fc.camel@alistair23.me>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix U-bit check to apply only to
 leaf S/VS-stage PTEs
From: Alistair <alistair@alistair23.me>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com
Date: Thu, 13 Aug 2026 02:03:08 +1000
In-Reply-To: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
References: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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

T24gRnJpLCAyMDI2LTA3LTE3IGF0IDEzOjIzICswMjAwLCBBbmRyZXcgSm9uZXMgd3JvdGU6Cj4g
Q29tbWl0IGI3OTVlYTBiYTQ3MSAoImh3L3Jpc2N2L3Jpc2N2LWlvbW11LmM6IGZhdWx0IHdoZW4g
IVBURV9VIGFuZAo+IG5vIHByaXYgYWNjZXNzIikgcGxhY2VkIGl0cyBjaGVjayBhaGVhZCBvZiB0
aGUgbGVhZi12cy1ub24tbGVhZgo+IGJyYW5jaCBpbiByaXNjdl9pb21tdV9zcGFfZmV0Y2goKSwg
c28gaXQgZmlyZXMgb24gZXZlcnkgUFRFIHdhbGtlZCwKPiBpbmNsdWRpbmcgbm9uLWxlYWYvdGFi
bGUgZW50cmllcy4gUGVyIHRoZSBSSVNDLVYgcHJpdmlsZWdlZCBzcGVjJ3MKPiBhZGRyZXNzIHRy
YW5zbGF0aW9uIGFsZ29yaXRobSAoU3YzOS9TdjQ4L2V0Yy4sIHRoZSAibGVhZiBQVEUgaGFzCj4g
YmVlbiByZWFjaGVkIiBzdGVwLCBmb2xsb3dlZCBzZXBhcmF0ZWx5IGJ5IHRoZSBVLWJpdCBwZXJt
aXNzaW9uCj4gY2hlY2spLCB0aGUgVSBiaXQgaXMgb25seSBkZWZpbmVkIGFuZCBjaGVja2VkIGZv
ciB0aGUgbGVhZiBQVEUKPiByZWFjaGVkIGF0IHRoZSBlbmQgb2YgdGhlIHdhbGsgLS0gbm9uLWxl
YWYgUFRFcyBkb24ndCBjYXJyeSBhCj4gbWVhbmluZ2Z1bCBVIGJpdCBhdCBhbGwuCj4gCj4gTW92
ZSB0aGUgY2hlY2sgYWZ0ZXIgdGhlIGxlYWYvbm9uLWxlYWYgYnJhbmNoLCBhbG9uZ3NpZGUgdGhl
IG90aGVyCj4gbGVhZi1vbmx5IGNoZWNrcywgbWlycm9yaW5nIGhvdyB0aGUgR19TVEFHRSBVLWJp
dCBjaGVjayAoYWRkZWQgaW4KPiA5MTU4YzkwMGFiMzApIGlzIGFscmVhZHkgY29ycmVjdGx5IHBs
YWNlZC4KPiAKPiBGaXhlczogYjc5NWVhMGJhNDcxICgiaHcvcmlzY3YvcmlzY3YtaW9tbXUuYzog
ZmF1bHQgd2hlbiAhUFRFX1UgYW5kCj4gbm8gcHJpdiBhY2Nlc3MiKQo+IFNpZ25lZC1vZmYtYnk6
IEFuZHJldyBKb25lcyA8YW5kcmV3LmpvbmVzQG9zcy5xdWFsY29tbS5jb20+CgpUaGFua3MhCgpB
cHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKCkFsaXN0YWlyCgo+IC0tLQo+IMKgaHcvcmlz
Y3YvcmlzY3YtaW9tbXUuYyB8IDE0ICsrKysrKystLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9yaXNj
di9yaXNjdi1pb21tdS5jIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUuYwo+IGluZGV4IGY2ODY1ZDFl
MTY0ZS4uZWQ5ZmIwOWY4YmM3IDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmMK
PiArKysgYi9ody9yaXNjdi9yaXNjdi1pb21tdS5jCj4gQEAgLTQ3NiwxMyArNDc2LDYgQEAgc3Rh
dGljIGludCByaXNjdl9pb21tdV9zcGFfZmV0Y2goUklTQ1ZJT01NVVN0YXRlCj4gKnMsIFJJU0NW
SU9NTVVDb250ZXh0ICpjdHgsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBJbnZhbGlkIFBURSAqLwo+IMKgwqDCoMKgwqDC
oMKgwqAgfSBlbHNlIGlmIChwdGUgJiBQVEVfUkVTRVJWRUQoZmFsc2UpKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBS
ZXNlcnZlZCBQVEUgYml0cyBzZXQgKi8KPiAtwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmICghKHB0
ZSAmIFBURV9VKSAmJiAhcHYpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBBbGwgYWNjZXNzZXMgYXJlIGFzc3VtZWQgdG8gYmUgVXNl
ciBtb2RlIHVubGVzcwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBwcm9jZXNzX2lkIGlz
IHZhbGlkIChwdikuwqAgSW4gY2FzZSB3ZSBoYXZlIGEKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogbm9uLXVzZXIgbW9kZSBQVEUgYW5kICFwdiB3ZSBuZWVkIHRvIGZhdWx0Lgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsK
PiDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoIShwdGUgJiAoUFRFX1IgfCBQVEVfVyB8IFBU
RV9YKSkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZSA9IFBQTl9QSFlTKHBwbik7
IC8qIElubmVyIFBURSwgY29udGludWUgd2Fsa2luZyAqLwo+IMKgwqDCoMKgwqDCoMKgwqAgfSBl
bHNlIGlmICgocHRlICYgKFBURV9SIHwgUFRFX1cgfCBQVEVfWCkpID09IFBURV9XKSB7Cj4gQEAg
LTQ5MSw2ICs0ODQsMTMgQEAgc3RhdGljIGludCByaXNjdl9pb21tdV9zcGFfZmV0Y2goUklTQ1ZJ
T01NVVN0YXRlCj4gKnMsIFJJU0NWSU9NTVVDb250ZXh0ICpjdHgsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSZXNlcnZl
ZCBsZWFmIFBURSBmbGFnczogUFRFX1cKPiArIFBURV9YICovCj4gwqDCoMKgwqDCoMKgwqDCoCB9
IGVsc2UgaWYgKHBwbiAmICgoMVVMTCA8PCAodmFfc2tpcCAtIFRBUkdFVF9QQUdFX0JJVFMpKSAt
Cj4gMSkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIE1pc2FsaWduZWQgUFBOICovCj4gK8KgwqDCoMKgwqDCoMKgIH0g
ZWxzZSBpZiAoIShwdGUgJiBQVEVfVSkgJiYgIXB2KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQWxsIGFjY2Vzc2VzIGFyZSBhc3N1
bWVkIHRvIGJlIFVzZXIgbW9kZSB1bmxlc3MKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
cHJvY2Vzc19pZCBpcyB2YWxpZCAocHYpLsKgIEluIGNhc2Ugd2UgaGF2ZSBhCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIG5vbi11c2VyIG1vZGUgbGVhZiBQVEUgYW5kICFwdiB3ZSBuZWVk
IHRvIGZhdWx0Lgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoKGlvdGxiLT5w
ZXJtICYgSU9NTVVfUk8pICYmICEocHRlICYgUFRFX1IpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSZWFkIGFjY2Vz
cyBjaGVjayBmYWlsZWQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoKGlvdGxiLT5w
ZXJtICYgSU9NTVVfV08pICYmICEocHRlICYgUFRFX1cpKSB7Cg==


