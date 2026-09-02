Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92116C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 00:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1uws-0000qB-Fy; Wed, 02 Sep 2026 20:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x1smz-0006EY-FE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:46:37 -0400
Received: from [203.205.221.191] (helo=out203-205-221-191.mail.qq.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x1smw-0006fz-Lw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1788385571; bh=griazrdLl1+fty1DmMxFxJZxpz/UEQ7LP0OXIEv1Heo=;
 h=From:To:Cc:Subject;
 b=JjMto38Xt/sLQcz1M4OGQLpRN8JDMtu6xEipFOP3WKKB+BJS0p5K16cOOvsOF0orh
 i3/KttfRqMyw1mzAH8CatOdoa48EI1gu72K4Rykblmq3fEtxIdTT4hT7KVLUCgpFCH
 U4likP7S27c25qjP0vVoiE3nSYSITSehsL/BuNC4=
Received: from Win11-9700X.localdomain
 ([240e:398:adf0:2560:208c:9ac8:67c:c74b])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id B89886B6; Thu, 03 Sep 2026 05:46:09 +0800
X-QQ-mid: xmsmtpt1788385569tpndfsvfn
Message-ID: <tencent_1D76D0E3949EA74891E11E5572119CDE2E07@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlw18RAbuZxtDOXD5vr+hOO39yeyu8mETJNTnMyuFplXxKv2bGvL
 M1JJKc1HGbVQ9t8FJaNtIAtZTt60FLX5qEK0GoAhwRQa2OuBnnoXAkzRKEfabp8IPJUf4RHxCVkr
 XYd2/xDmq87M397hZw01CLBUzDpQTs8TlZ5Vs0yUvoYkUWJFe3clS7r5x/w8C2Olnzpx5KMXrQXi
 xV+W+O0l81AOGBEXjhrr2BauOMFUqUyb+kSxwbljSO2jy3xhJOsVShRyU3BJwVhittcUrqsPsbeq
 Ns2BgPAEpBU2KQlAM3dMNaSwIk8MD4mQ5BA/enK6/6GmIusIzg3fU4Fb0yBM5qUGpMmLqWlmoKKS
 DyrjBGSzfIpNZMnHR3g8IHLFAA+4CYI9FCk4WHu/ROjTthdz8sbu+63+iaNVwCCZ7W2SEgl8VzxU
 cuwttvqdCreyWM3NzZ8G7yDeYuMsDHav91/L7v3CfeQRS1WJ8XG+z4IyHDYu/6jmMOT4vA7VBUW/
 aDv6iZddK/dXRb8w53mqAanuc57UbozTi9JADO1AQiWXx8wALTJSu8C4O53+Fmpp+9FBc1Yv+OEl
 7MvzkjgP+jF0fbqB2PWGklK04wbY7ITZDTd02nT2+m/3WbLVAh6deHV8wyo74j4ItnkauOOgi02O
 cXD06mS45o9ZvpZ+TpRDlN9WVGi7t1NV+87ALVqtu+cL0Q3Aj/e3aIgHH4eSLT2Ik6/bodof9Xe6
 YHLiG3HvPs36aDu5wWK9vuZtG5emIC6CljGHHo4oxcluB3B0ThK+WZ/inqeTRNgg13zUwYcoPrrw
 UzLGE5xtOUVw/gFszn8FNAIF8U5188CgXz8v1xPPSw9rGi7ND2ktLCVkulehQbi18Hd/OHOXQRBh
 y2shVqoSEd4vAGzSqaZMqqavKUzMe6AqAKZUVW6KJgtOP4B4mYHBOC/iDMuN1F4WyNKI3F9bLgMJ
 wJrHtelq4Lo9U5rboWAu7JUDmEE+cL0OdMHL4iy7WbhlvhKFLhiX3LMBOujWpU6dcLEs/DJJY671
 tzJtWqnLYR24f5GUyVpwzuWgdcDq1ceWX0rt/r/A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jiajun Liang <3138947285@qq.com>
To: mohamed@unpredictable.fr
Cc: qemu-devel@nongnu.org
Subject: WHPX: stale page-table shadow after delivered #PF stalls macOS guests;
 VP recreation bugchecks the host
X-Host-Lookup-Failed: Reverse DNS lookup failed for 203.205.221.191 (deferred)
Received-SPF: pass client-ip=203.205.221.191; envelope-from=3138947285@qq.com;
 helo=out203-205-221-191.mail.qq.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001, MISSING_DATE=1.36,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
Date: Wed, 02 Sep 2026 17:46:37 -0400
X-Mailman-Approved-At: Wed, 02 Sep 2026 20:04:56 -0400
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

SGkgTW9oYW1lZCwKCldoaWxlIHJ1bm5pbmcgYW4gdW5tb2RpZmllZCB4ODZfNjQgbWFjT1MgMTMg
Z3Vlc3Qgb24gUUVNVSAxMS4wLjUwL1dIUFggKFdpbmRvd3MgMTEsIEFNRCBSeXplbiA3IDk3MDBY
KSwgd2UgaGl0IGEgcmVwcm9kdWNpYmxlIHNoYWRvdyBwYWdlLXRhYmxlIHN0YWxlbmVzczogYWZ0
ZXIgYSAjUEYgaXMgZGVsaXZlcmVkIGFuZCB0aGUgZ3Vlc3QgaW5zdGFsbHMgdGhlIG1hcHBpbmcg
KGhvc3Qtc2lkZSB3YWxrIHNob3dzIHRoZSBQRFBURSBwcmVzZW50LCBlLmcuIDB4MWY1NmM2MDI3
KSwgV0h2UnVuVmlydHVhbFByb2Nlc3NvciBrZWVwcyBmYXVsdGluZyBvbiB0aGUgc2FtZSBhZGRy
ZXNzIGZvcmV2ZXIuIFNhbWUtdmFsdWUgQ1IzIHdyaXRlcywgUENELXRvZ2dsZWQgQ1IzIHdyaXRl
cywgYW5kIGhvc3Qtc2lkZSBwYWdlLXRhYmxlIHJlcGFpciBkbyBub3QgcmVmcmVzaCBpdC4gVGhl
IGd1ZXN0IGxvb3BzIDE1LTIwIG1pbnV0ZXMgZHVyaW5nIGVhcmx5IGJvb3QgKGtleHQtbG9hZCBt
ZW1jcHkgaW50byBmcmVzaGx5IG1hcHBlZCBrYWxsb2MgcGFnZXMpLgoKVHJ5aW5nIFdIdkRlbGV0
ZVZpcnR1YWxQcm9jZXNzb3IgKyBXSHZDcmVhdGVWaXJ0dWFsUHJvY2Vzc29yIChyZWdpc3RlcnMg
c2F2ZWQvcmVzdG9yZWQpIGluc3RlYWQgYnVnY2hlY2tzIHRoZSBIT1NUOiAweDAwMDIwMDAxIEhZ
UEVSVklTT1JfRVJST1IsIHBhcmFtcyAoMHgxMSwgMHgzNTc4YzAsIDB4MTAwNSwgMHhmZmZmZTcw
MDAwYzA0ZGMwKSAtIHJlcHJvZHVjZWQgdHdpY2UsIG1pbmlkdW1wcyAwOTAzMjYtMTA5ODQtMDEu
ZG1wIC8gMDkwMzI2LTk0ODQtMDEuZG1wLgoKRnVsbCByZXBvcnQ6IGh0dHBzOi8vZ2l0bGFiLmNv
bS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDM4NSAobm90ZXMgMzc3ODEzNzU5OCBh
bmQgMzc3ODE0NjUxMikuCgpBbnkgcG9pbnRlciBvbiBob3cgYSBXSFBYIGNvbnN1bWVyIGlzIHN1
cHBvc2VkIHRvIHJlZnJlc2ggdGhlIHNoYWRvdyBhZnRlciBndWVzdCBwYWdlLXRhYmxlIHVwZGF0
ZXMgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4KClRoYW5rcyEKSmlhanVuIExpYW5nCg==


