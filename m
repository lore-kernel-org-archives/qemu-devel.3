Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81B0E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7L-00078q-K6; Wed, 18 Feb 2026 16:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-00076m-HN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp78-00079M-Qq
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450178; x=1772054978; i=lukasstraub2@web.de;
 bh=EItZ/+gLUzr/5kLXi4A0a68bhxdVbobY0N6WGPa39kA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BfnBIuLKbyxcvTFOJRT1UrSj3kHJxdCYh5C1uaD/a9Nc3d/ZcKOC6W7TLDICultZ
 H8JiwpD8dDtyDCS3TZi8lyOKdWhtAKk20MezWylElR+bM2SezUe6aZ8lWhPA/TyjI
 hmHzXm9nuTeDdEuuK2HfXJxZAF2gGsBFtXVEuaU1wCIZhtO3Yb1aSfG28eANZpOa3
 9ti8eEUaMcGCp35d31v33x30UKsVFjsvM48F6KvqTeNo9QKhQcZkC+m0FWxBvNGK/
 ZcdlTkXtJeChtemCcN7FJo/fY7MNGzPqJt8/gYZEAnXYosN7R60VO/QIGFt0+M3HS
 UdeWpKC+vaibzfsdtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1vxCqH3FGi-00HXRr; Wed, 18
 Feb 2026 22:29:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:22 +0100
Subject: [PATCH v9 02/19] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-2-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=is3YRplQqUwEeytK+Q8qH2cF/R5ufk9k2waP/h9xIHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli885Dljd8DCEmeYqCxQH3T02h7ZLdFGoc6yr
 6fMnMDUaWuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WLJID/9IrtETpDLWRFwAhfPrICpNxjHrS1hHzxvkgj4I0ch32cJ2aj3Np9WkEmqCvt7Rknukbqs
 0GxZvuo3wAtr9GptKPO2GsK/4zlsbT/UYSjsNJT4p7i3C/hUBH7Jr1R1OnlsePzWIXgkJD25GoD
 GNJnazdixhWUXdxKZsYGkrG8wWd1gsQlfZBNYht7bnK/QjStMS6aMn2sgE7pu8N2c520VfmDyJU
 0m+WXuEYpYWJvhs6hOHAZvvtQ6YXIbo+6C3ca5nhjeOIHUQ8guGO6DXAw18FooWVio5bYY8r3/C
 oaQjvtp6Dj+YjPeQHDw1+be2wUUAF8rVfiyouScErBITIywRHapbKVE5YLsPB2XFfayRd/bKHN8
 m7+CNqLgz22n/ovA16H2B4bcTXzzbyP6KLaS0w3lJOTPnnSQpAxCgne1biJDiPGhprfBHGa+fd6
 X1ksqZPZqUF5WzkyF8gA3C+Y2WX6fSMPhX146Jhd4JuIOBOEOwK32g6ZE7Wep3laaREuuunPg1z
 LSp1acuKrxibM0nONuPs+dXHanQ8sh0J+gmX2osgawq0XQeCi/9t6scXSUako1TPGN4HAdqRkfk
 Rx982A3JLEOlwR2Y0ytt8jAxJ440lONJBsdT9IrftC8YC/QRV1NobvPBZcdCyNSYo+lkP+kxypX
 HKFDNNP82JqsiIw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:3bJ7zSH0JABvk4AJo5W6mq3zs6BviddYxBn4EciPOt+CG9GttBb
 2KD0tjpzE9PEz2giz2ZgD9wSApdH5h3MGPneCOPZdub4Y10XjGq/9m4Nr9q6DLEeLvmQOzP
 FOo2uYXptwErhf6xsKORsrw19ALH7nfppwv9iQ/bIJFxv1oWuSf9BrCNXU+b6OC/DFE5GL/
 3FwNEaZWhTCq2SFZ8tZfg==
UI-OutboundReport: notjunk:1;M01:P0:i1tTsz2+2Vo=;QRa4veSwTPo4irbbub4vQF9BGFD
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2458241e3cd45673d7228a3fecf2fe94f3b51b77..3c4eb3bc744e23dc3d49d14b24=
a0d576d7bd60d6 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3865,7 +3865,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


