Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B13D6CFB8
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6un-000797-70; Sun, 25 Jan 2026 15:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ul-000781-MX
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:55 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uk-0006Dz-3z
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373642; x=1769978442; i=lukasstraub2@web.de;
 bh=C/CYeZCotevsdE8XEi46rLuLUe5boOkt18D4aIjbX1U=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lNelhG51SLNz/bSLfoTgVSmGK/B/lXdnWfNC7YAH0XAirpEXSx5voa1lXWcM89M+
 QKU//OUmc/p3Bfr792VpZZVmNoY4VDlCMMkfKz8p+nDmAfPj/Mf1vgq5N93v+P6BG
 +RQBPjJjDKwwhA9zkTOfmJLE3r3oWdY7NThGKFpGMLUxJlpBYB5nABMdFgx6f3pON
 6LlvwJ9xiTknexVc52zeFLclxtm69AKAt8SoN7ned1E1a7xv9jcXmiVjOGtaWbeYU
 Dob2yAwVw2Ov2YaPnhB5IHIsBn8bjHJyqmb2pTXz10oEAnY9ULuiTkjVf67pUE6Gj
 ejsIB01eh1bgM1J1/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1vaizY0fQo-000rsA; Sun, 25
 Jan 2026 21:40:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:07 +0100
Subject: [PATCH v3 02/10] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-2-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
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
 h=from:subject:message-id; bh=7pYse0rrV+Cy2p7m+a+OC+e/bUhXDuYJa+mzuTARfc8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/FOwlGIUeyfPSeKoggfdHqcVY1hNOQf1+C1
 6dP1T5+3yqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WMwFEACKjG2NimZ/6uh2l139frm2H9x55bV0DjIqnfDtyGfqx5q8HuNBA/ANYfYALz4Cz2qAush
 sAZD559UElB19WiTGNP55cGrqP8iMzXdRi7hOdVzMoysazKEe/OtepYN4vvB6w4Oqf1xnsmu3m5
 Nh9wZSyYBzGI5E2/bf+z/Fxwbvz2hQTBRVgV/IirCM7FX2b3lQfOPQKRa0ClNGE8Lg4P9k93Vi+
 g+LvylD3JJnt0aQuSCQPdSJFWrWBNBCmAJ7HYa+7NvxPXMxX3ExR4pSWtbR+ITTrhYgxZbCXZnV
 XLuvg9kp3l5276VsLZrvbuMFe4jtCT6wfvbxlKcnxZ+7EZOb5OUwTgSmi2Tr0Ih/jAnSNe06+C0
 890BOtihObFhRzzjcoFygzjGL4S96vX4L4sZcsu72caybKGNHiejw8RwsD5k5AMvqqVbDU8tuC6
 /3S2M0DQ1XuRGEMimmh7o4r8Av5jAAiJ2cZJr6PP4HPLPDHzs4RjNbpwXD/V1i+3zIBmepWJ10M
 0xRiOQXtkbdghGBd9+/9HI/8GnwHUJ+Vv4yBjsqQT1NUsZFd7HOMSbZqA8magnNAC6rDMbeqBmg
 GMK2xdz0CvXPTMaOdfbSEQ8Vh6EjwZJM+x45WTQQDlaRR/2U6VRODetHGPqz8La8xI2RPMm6qMh
 OgiV7NjE1MBXt3A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:PkWefO7bVrVVPWddpYOKiaKu28dVIbfjUWzCKUkmp2zk9i2ySM4
 Xc19Uswtb+GojjrM6VrDXeNLqWq8tNND72nyufVVRKzGHhnEBRQSdj8yiRShcWi3scfrI5G
 UKwup3SErfcp/fklIsyhs+7MWVcVVaplMjVAhuTjTtWnLMiQMBeEMyYmhjOQz4ps5ZteQCZ
 r8M4Jpt2yBuzcBMVATtdg==
UI-OutboundReport: notjunk:1;M01:P0:lGJCcmOWWBY=;ev+vw6OyVMoAgkHCIkX+6b7ZmOD
 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
 nfyxSLdP9c7S4zFCx3h/t2RfxEvbi
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index 689d79b82d39ec8c2bb15dacb7928df5649756cd..1e9bdd87c3a2f84f3abfc56986=
cd793976810fdd 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3850,7 +3850,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


