Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474FCC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKe36-0003xu-Sk; Fri, 21 Jun 2024 09:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe35-0003xa-Jn
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:27 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe33-0003mF-TP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 43A551380200;
 Fri, 21 Jun 2024 09:11:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 21 Jun 2024 09:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718975485;
 x=1719061885; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=
 s7m0ut1kbPaGtC4Ey8UiAd+3fFuFMPpttpFhWm5WPNgOj1IgKjhod8I/y9hlYhqk
 F+S8G01jgJbVlYtPwAlRWvW08sPeQpLWt+n7XAU5LticB6fIze2x+B950Mchk4G1
 Ah2SeNCGyGjPqe8B5l/NmMThHbhbUIl1dDCAKK7zsAh80ASC10cuKCXdmp98Ekck
 vSGJvUdWDsSe7k9v0mOFXQQ6nSDytCXKzB4mdYrkYdBH/4phqa/e/p0D3mSYFOIJ
 kRlYjMgCpMeo5uDz3GoXt/iymGHGYgaU4AcfE7svDxMk9TTKYtym3JYCDaMcGZL8
 4Zj0oldgh9tfbdl1mBg84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718975485; x=
 1719061885; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=s
 K/X3XRNQjowLDDlDLRqLLp/dk/cFLpsUeCiLVXRdyUw/s3LH/PyjnfBxlsFb4tQ5
 t8+eUennaqFQNpGKjgbfbs1+RTTtvgOSshxrp1ATgYJ4Peqj+MRjoSS/6QAT7F/D
 uzo6xfj8DdsUUVuDghzfTdws+9aTBE+NZK21JeCVxTmn8fODlzRE/Mi164St1BcC
 vaF8HTy/zsSpEEAP55t9AwCe8kKbAN5/h+Lo8jVvPVkRHLzHik7VhH1/lY+EB8xP
 NNDinFOXvP1l89+t0vjPMVNe9fnJn7VSIr1BkF/yLedDncR+JF5UGJRq+njDF/gR
 d+chvqPwYzndEnbAca5Dw==
X-ME-Sender: <xms:_Ht1ZlhvvdTs_OUaOpbsYS5IfGUHV5uCH6I-oYQiTJfcs2KDrn8YZw>
 <xme:_Ht1ZqCUxwNs76BlKTTBnPO9NUG58AueDxKb_PQZgRjl48KM_dNLyXJOnpLFyv6Kz
 x1eCQklOm8CsziOpCQ>
X-ME-Received: <xmr:_Ht1ZlFgYqYD6q-MFKyVh1_VdZ95h9V5JwzpBmS9tBLP-TYb9GpUV0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_Ht1ZqQ0-4f579W61tJ4EROwxOajawT3MBEE7bnd0x6Ny2uaocchKg>
 <xmx:_Ht1ZiyGtJJoFNe4wEJ9A8ha2kJgF-q8ITEZDjz-VvOEx2wQXe0sag>
 <xmx:_Ht1Zg5F3wATzNsbAMKb4BQ64mzcaQ0XHStXSjpwTml01pXCh6IinQ>
 <xmx:_Ht1ZnyMoDYfTpCx5MuVisBh3prEGpG1_lLwsrcYHgYhby8kgAMI-Q>
 <xmx:_Xt1ZplaRZ4nNwmGjZZlht1hkZ2AeY61gC5GDCwvQQZ2L3peqIdevP1t>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 14:11:15 +0100
Subject: [PATCH v2 3/3] linux-user/mips64: Use MIPS64R2-generic as default
 CPU type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-loongson3-ipi-follow-v2-3-848eafcbb67e@flygoat.com>
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=g3k3nWcLqtTiZ2wMMOFp6to4dK8fiS1Lxyx+pASHj8Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p+MrSf+P0yUeaA1S6x+9RKlJiG/JIfIt5lzPimsS
 jkguNyto5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbyU4zhrwjbhUeSRiUfZ3xT
 SVPx+uyuadzWnP6RNWeZvt9N9ecL7jAyfG91satd7OM7R/Zr7e+yPulJcbwaPz6W73rlkrB1sks
 ZGwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
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

5KEf is some what not standard compliant by having non-functional
FCSR condition fields. This is causing glibc test failure in
qemu-user.

Use MIPS64R2-generic as our default type, which have maximum CPU
features.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 linux-user/mips64/target_elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5f2f2df29f7f..82bb7e8b1cbf 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -15,6 +15,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
         return "R5900";
     }
-    return "5KEf";
+    return "MIPS64R2-generic";
 }
 #endif

-- 
2.43.0


