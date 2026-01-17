Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27DDC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh70S-0007kO-L2; Sat, 17 Jan 2026 09:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zp-0007WF-Mf
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:48 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zn-0002bD-6w
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658974; x=1769263774; i=lukasstraub2@web.de;
 bh=3TmbXJbcC5dTi+rX4IClFisOQdgZFG3ImhLkNgl+bNc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BgR4EHpZKVB+ptFcju4naGQIofxXpMFS/VI104rDbB3Ra8ab92gUWLP/pKPeFbJE
 UPYzegG7P40Gl9iVbgVtTBgT8CUAuvruHfhBrSI3xVtxi9cAKdwlgHrPboNanYQgh
 7iredPPej9edcluOFWvDgSYvMQ46OEAj55smbUHo87kxfcv7ZvmCWMkdRi1GHu3we
 ajmgeVk4AQwRupDaJViweCMSvk8L8N/k1YrTSgZJkcyXMTn0qBuTao30sJyKXITSB
 IICTUaqXwlzWsy7R3udIFALxJJY54yRgXg05ACmDzhFf9+q6L8zTgv3XWmXXPgd3o
 LFbUBlvXeipez5BUWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1vZS1q3Enc-007fJE; Sat, 17
 Jan 2026 15:09:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:09 +0100
Subject: [PATCH v2 2/8] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-2-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=657; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=8BO4SS+x3Jail3800Bz6gqn48I2qQl3v4b0zLdzfvgU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gbB8cDI68epdQ3LGManIKUZkRf6Y+sn37aM
 /s6sxgg4OWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WD5vD/4zrHDIOqxNgOSsoiUhluLKs3jMwH7010iHiRd51WzF8NafGXz5gUEyTVRSIbOMnviIZb/
 kXGvdOcwkwVRKJ3U7wz0IYppc7Fu4TOECFXHRBsjAtv529x9QfgWnTY/J8tFloXIUIjocOkVfUl
 cJrm/uMp6RL00XVEYv1dyB2Mp3/DXdZrie0Jdd75K5cILss59WMfIghNBuo9eMuB3nCLoIk4TX4
 kB7LjwfdId0zYZW6H0eHZQCfMAFQJb6jImJ55OB+ujhLCs2UAg1lNQaglVAbbpnNqZWLqCy7MIw
 B9tUKGK6NohKtkyJ2cZnbcTxMYruXtmKgCL6Psl1X156JLkFS8vsSGZdvbfNyNcglMuEpREittz
 f3voTeIXTQ2Fz2xVnyAIsxl3JXXoiNp2w/jnp/TFr5k7CUn4UDfRB+8kCRy99BCzJzjZ9e2lvCT
 CaC/f2sIhKfNgJ/dF4PpaVvi2BHjWRk62jwU5s11JK/OGFWZIxJHqUr5hClRTmMFaJjbBOYBr9Z
 ifap34LkUKUlKIO4FoUYllfaGvcrgzxm2dYa+DEhME8Wjas7l77EUlDouFSYtUD1JRQbTYGvlw9
 oQZHB4rJeO8V5IJS0j3yuc5L6LtI7etV97FOnHtwIyx7DcRbhj76jeQ3lqA4CuaswWIVO3u8gl0
 J4Bps73ivnt4/Kg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:3Bw+korEzPtYYUQXXTlO5/NUxA61xFvrZYH5EzAmwvH3Bx8qZJP
 zX/zhzjhbLE/rxe1LfwJj/MSetW0JpRqIGXYPc2D/DhFmKdPvhIPwSj7bX4xVr2SVvXK44a
 /9uSGipbcJlwdaNpgxwx1JbnC9dJNL1O81DUgl0L2N8h7tHTqVC9vVTJBpPTNHe73YVBiTY
 cbJz5Ck5k7ezFzIGcZURw==
UI-OutboundReport: notjunk:1;M01:P0:u9rT3H3oX2o=;pVKdvtJO2WShJ2zkNYc+0ZKviaa
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38691feea8941635c7ce45f30a822030016e922f..563804345fec68ee72793dbb7c=
1b7e5be4c32083 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3834,7 +3834,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


