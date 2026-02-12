Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE01EE368B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXNv-0000hY-PV; Thu, 12 Feb 2026 09:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNo-0000gC-6V
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNm-0006QC-Eo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so65897575e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905365; x=1771510165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3cLi2JyUm8wKd97bhkRBOBT0oLXAVRHi0iTXd33KdY=;
 b=ZweqdSaxwMnuxbs0GxNbZdZeGUI8d6h/xXdSFqsC6s93XzXckb59j4BJ/IsR6+84lb
 oVac8Fkcjp8Y2mzrRnZnHrj7DwEXzyO2sgSeUz42Gs8sdEAKEN+3tcpfEghFkKqu25+1
 v77FdKmfoqSQQyuG5o8ZrGeKs3qAapzPf+Pkb2OxETFifMsjBgq99ANX6oyLFoZZq54f
 EVPQHvbz8+UiAT6lIlv7Jo5vi/Xlg7TYCS/wujAuqjCE6TVOFc2DOfxx0lUTLSV3P8kI
 arYKFJfKKRyv95lOz2wj95ZzF8caRdRS9R4pQrl5n1PwUWn2KlH1BjmskhpJc60hiVHv
 7dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905365; x=1771510165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3cLi2JyUm8wKd97bhkRBOBT0oLXAVRHi0iTXd33KdY=;
 b=wF6EutAqcJjvRykIxTUqVLxdgPECGFdsEHolLA1AGiO7zb/7CadF0oatLiT2FTNCyH
 XcbegAgbKqULCc9D8dUWo53ssJ5bg9yD2pfqNt+fAhP08r8hlhZqvevWe1Bd9/plv2V0
 xx00+JKzcXMn+vazeKa0MpHJfOx3zmZUyni6EpKIaPxhqG+DhpFdZ+KhiBOSMvJCEfLy
 +gRhpL5GbywHgfvpyBt7YXZefE0b8Rk2hiV2SPSH9Yn9/+WQhx3w2jDYcanQlru0HQYD
 dTs4PCITjuMsiab62drwqORdJPmsjnphYNARDBMiB5yTDZJ2xDrTQoar9fdfXsM03GPR
 b5WQ==
X-Gm-Message-State: AOJu0YylwVma2ObcXvpy2fp/rv5DgE34GXBp+UAtugVrovVDnwrWhNcI
 P+y+La6R8KcPNkk7OMBXPTAfk6xX1Wl91hSZ/ZYZNs5rB8VDjcIowjAHQ0v14f4te21nhNZzlwd
 /j/8w
X-Gm-Gg: AZuq6aK1ju8tnEAEvcHI6lMfggD+2Ud4tj1VYQ0XSPZK6bLpUbpbGkwrC4+3N6n7YUy
 fWqMwEQIR6jp6Kih01xwHkLVD1ngT0gQbJNSSQthPsE6E8cTAVnz7pp4H7rISLYVjnWbgb6tXcj
 ACK5C9r3d6T1lFrhTbXcYvPHssvtNssMnDfZKOZasjLE2/YWTiMTeWBWqeJfeMb41tVZx1JFb5p
 1fI+jebhBwe79/Ru4OlmpUkXjwQ+MyAk0StyQfDz0B3MwP4KIeNMnrC01mszUs0FdIdpjP8d76Q
 8sMdEiRUTr75zZFB7Oc63j5LlMbuvewDpbxv4RtX0eHEuIWUParULLyHBsaWbCgVcbrZK+67gIt
 0eshipP/jqs5xLaFf+tQ84WatfobDqPMB4X0q8Ha2RIBd9dCIkgtrUB0M4Msetdr0K9Ib8z0YvJ
 ZPJeQyLG71+wfUSWgrPjBCKJaFrgivD/UcZZeIQElptLPn8YwLvTuQ5OM6EhzGW44SNn2/jbmSL
 JoOUsPh7zQ7OUI5cZvdrXtWmxsO9Mw=
X-Received: by 2002:a05:600c:8b2e:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483656ae449mr37134725e9.3.1770905364554; 
 Thu, 12 Feb 2026 06:09:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 3/5] net: mark struct eth_header as QEMU_PACKED
Date: Thu, 12 Feb 2026 14:09:15 +0000
Message-ID: <20260212140917.1443253-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The eth_header is not actually guaranteed to be aligned.  We attempt
to deal with this in some places such as net_checksum_calculate() by
using lduw_be_p() and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member within
a misaligned struct is undefined behaviour.  The clang sanitizer will
emit an error like this if you run the sifive_u_mmc functional test
with sanitizers enabled:

../../net/checksum.c:78:47: runtime error: member access within misaligned address 0x561f52f35011 for type 'struct eth_header', which requires 2 byte alignment
0x561f52f35011: note: pointer points here
 00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 00 24 00 01 00  00 00 00 00 00
              ^
    #0 0x561f20608459 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:78:47
    #1 0x561f20117bfa in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
    #2 0x561f20115c61 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:78:47

Fix this by marking the eth_header struct as QEMU_PACKED, so that the
compiler knows it might be unaligned and will generate the right code
for accessing fields.

This is similar to commit f8b94b4c520 ("net: mark struct ip_header as
QEMU_PACKED") where we fixed this for a different struct defined in
this file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This came up back at the beginning of last year:
https://lore.kernel.org/qemu-devel/CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com/
but we never got around to making the fix.
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 14c34f530f..63f598d7cd 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -39,7 +39,7 @@ struct eth_header {
     uint8_t  h_dest[ETH_ALEN];   /* destination eth addr */
     uint8_t  h_source[ETH_ALEN]; /* source ether addr    */
     uint16_t h_proto;            /* packet type ID field */
-};
+} QEMU_PACKED;
 
 struct vlan_header {
     uint16_t  h_tci;     /* priority and VLAN ID  */
-- 
2.43.0


