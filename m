Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E233C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPewV-0007tc-Jm; Fri, 05 Jul 2024 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1sPewG-0007mv-NP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:09:11 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1sPewD-0005Bg-4q
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=Kz7GGAYLaqsOn+tXcbm3Kg3bi9h0eIhysvePcdg5zvA=; b=f
 4MXdMjKTpmMAsgYHDCYcPl4m5U8A2GiKgokOhFrgMDb//1DIqUTJLG/Dvcwf1cw7
 sZ2DjihA+YWKwwtCLbjGmA9GfAR/KsSHHs5ozGBx+6dQ97ewGy5Ohv7aynuILaTp
 pce8o0FgKlsENOavPxjarqxuiL4ag8k4xIMGYaP1uY=
Received: from 13824125580$163.com ( [14.125.52.22] ) by
 ajax-webmail-wmsvr-40-110 (Coremail) ; Fri, 5 Jul 2024 17:08:49 +0800 (CST)
X-Originating-IP: [14.125.52.22]
Date: Fri, 5 Jul 2024 17:08:49 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: About VFIO Device Pass-through on Qemu.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZAv2cv00p7yaRbekfm0sQjuY3UcOxvPsk245RO51wjCfp1gA4cmZAEHvu++GDCSKGtRuUeyBy2+hbZapjRoQKJFwNd040Mwf09eHZoAdbRQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_135936_1083224208.1720170529702"
MIME-Version: 1.0
Message-ID: <17672e.9050.190822743a6.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD33+AhuIdmsO8XAA--.15752W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiZRoTQmXAm13BZQADsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.3; envelope-from=13824125580@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L3=0.001, SPF_HELO_NONE=0.001,
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

------=_Part_135936_1083224208.1720170529702
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CgoKICAgIEkgaGF2ZSBhIHF1ZXN0aW9ucyBhYm91dCBkZXZpY2UgdmZpbyBwYXNz
LXRocm91Z2ggdXNhZ2Ugc25hcmlvcywgUENJIGRldmljZSBwYXNzLXRocm91ZyBmb3IgZXhhbXBs
ZS4gZGlkIHRoZSBHUEEgdGhhdCBob3N0IHBoeXNpY2FsIG1lbW9yeSAgbWFwcGVkIHRvIEd1ZXN0
IHZjcHUgdGhyb3VnaCBNTVUgbXVzdCBiZSBpZGVudGljYWwgd2l0aCB0aGUgSU9WQSB0aGF0IGhv
c3QgcGh5c2ljYWwgbWVtb3J5IG1hcHBlZCB0byBndXN0IGRldmljZSB0aG91cmdoIGlvbW11PyBp
ZiBzbywgdGhhdCB3aWxsIGJlIGNvbnZlbmllbnQgZm9yIGRyaXZlciBkZXZlbG9wZXIsIGJlY2F1
c2UgdGhlbiBjYW4gc2hhcmUgZGF0YSBwaHlzaWNhbCBhZGRyZXNzIGJldHdlZW4gZGV2aWNlIGFu
ZCBzaGFyZSBtZW1vcnkuIGJ1dCBpcyB0aGlzIHRydWU/IGlzIHRoaXMgdGhlCnBhc3MtdGhyb3Vn
aCB1c2VyIG1hbm5lcj8KCgpteSB0aG91Z2h0OiBpdCB3aWxsIGJlIHZlcnkgY29udmVudCBmb3Ig
ZHJpdmVyIGRldmVsb3BlciBpZiBHUEEgPT0gSU9WQS4gYmVjYXVzZSB0aGV1eSBhcmUgYWxsICJw
aHlzaWNhbCIgb24gR3Vlc3QsIHdpbGwgb2ZmZXIgYSBjb25zaXN0ZW50IHZpZXcgb2YgbWVtb3J5
IHJlc291cmNlIGZvciB2Q1BVIGFuZCB2RGV2aWNlLCBidXQgaXMgdGhpcyB0cnVlPwoKClZDUFU6
CiBHVkEtLS0tKE1NVSktLS0tR1BBLS0tLS0tLSgrb2Zmc2V0KS0tLS0tPkhWQS0tLS0tLT4oTU1V
KS0tLS0tPkhQQS4KIERldmljZSBpbiBHdWVzdDogICAgICAgICAgICAgICAgICAgICAgCiAgSU9W
QS0tLS0+KElPTU1VKS0tLS0+SFBBCgoKVGhhbmt5b3UgIQpCUnMKemxjYW8u
------=_Part_135936_1083224208.1720170529702
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4m
bmJzcDsgJm5ic3A7IEkgaGF2ZSBhIHF1ZXN0aW9ucyBhYm91dCBkZXZpY2UgdmZpbyBwYXNzLXRo
cm91Z2ggdXNhZ2Ugc25hcmlvcywgUENJIGRldmljZSBwYXNzLXRocm91ZyBmb3IgZXhhbXBsZS4g
ZGlkIHRoZSA8Yj5HUEE8L2I+IHRoYXQmbmJzcDs8Yj5ob3N0IHBoeXNpY2FsIG1lbW9yeSA8L2I+
Jm5ic3A7bWFwcGVkIHRvIEd1ZXN0IHZjcHUgdGhyb3VnaCBNTVUgbXVzdCBiZSBpZGVudGljYWwg
d2l0aCB0aGUgPGI+SU9WQTwvYj4gdGhhdCBob3N0IHBoeXNpY2FsIG1lbW9yeSBtYXBwZWQgdG8g
Z3VzdCBkZXZpY2UgdGhvdXJnaCBpb21tdT8gaWYgc28sIHRoYXQgd2lsbCBiZSBjb252ZW5pZW50
IGZvciBkcml2ZXIgZGV2ZWxvcGVyLCBiZWNhdXNlIHRoZW4gY2FuIHNoYXJlIGRhdGEgcGh5c2lj
YWwgYWRkcmVzcyBiZXR3ZWVuIGRldmljZSBhbmQgc2hhcmUgbWVtb3J5LiBidXQgaXMgdGhpcyB0
cnVlPyBpcyB0aGlzIHRoZTwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+cGFzcy10aHJvdWdo
IHVzZXIgbWFubmVyPzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYg
c3R5bGU9Im1hcmdpbjowOyI+bXkgdGhvdWdodDogaXQgd2lsbCBiZSB2ZXJ5IGNvbnZlbnQgZm9y
IGRyaXZlciBkZXZlbG9wZXIgaWYgR1BBID09IElPVkEuIGJlY2F1c2UgdGhldXkgYXJlIGFsbCAi
cGh5c2ljYWwiIG9uIEd1ZXN0LCB3aWxsIG9mZmVyIGEgY29uc2lzdGVudCB2aWV3IG9mIG1lbW9y
eSByZXNvdXJjZSBmb3IgdkNQVSBhbmQgdkRldmljZSwgYnV0IGlzIHRoaXMgdHJ1ZT88L2Rpdj48
ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPlZD
UFU6PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDtHVkEtLS0tKE1NVSktLS0tPGI+
R1BBPC9iPi0tLS0tLS0oK29mZnNldCktLS0tLSZndDtIVkEtLS0tLS0mZ3Q7KE1NVSktLS0tLSZn
dDtIUEEuPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDtEZXZpY2UgaW4gR3Vlc3Q6
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+Jm5i
c3A7IElPVkEtLS0tJmd0OyhJT01NVSktLS0tJmd0O0hQQTwvZGl2PjxkaXYgc3R5bGU9Im1hcmdp
bjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+VGhhbmt5b3UgITwvZGl2Pjxk
aXYgc3R5bGU9Im1hcmdpbjowOyI+QlJzPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij56bGNh
by48L2Rpdj48L2Rpdj4=
------=_Part_135936_1083224208.1720170529702--


