Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD94CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsT-0007ti-L1; Sat, 02 May 2026 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsN-0007sO-Ri
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsM-0007D4-GP
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dea20cf21aso2779661a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741893; x=1778346693;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/V+9tfaRgt5CpOg/C2Wds64ohNNT4UAweJWSemJjSNI=;
 b=XAMIvlpPA/NbP+mpPgkZQ0n0eqClSOieMYPTLWV0AJ3qcx4MiPsjgW6nPD/Hu1rLM6
 Q+fw33biLKJAtR187MRGuQ46P0vOFL1U1miAYkq3lQI5VxXzhK3jBO0OIOb9v9vHPNqt
 sU7mdsOjjGcNGZ7AUzF9F2Fevl28iOWN+8G3X8M7nlBQlqcGvbu6SplNLPLS5mdTw/8N
 HTMf/0o2E/lD0xEHOlg3+XySF23T2UAP23jo0+uYHTi2fQxQRLlOxxrp8BFprG6pn15U
 DfJMd5y9ELj4ecqk6+4eCjzLEvlZBFfG/pPCNlrmIXIbx7eQ++u84maTHThgjRE7Q7MX
 8NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741893; x=1778346693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/V+9tfaRgt5CpOg/C2Wds64ohNNT4UAweJWSemJjSNI=;
 b=RK8oBiZiOTI083CWu8fxfAabUetEQlYEJPCZICJytk5sLvlrL1Dbxam0T+ka54xz4Q
 2lIuOkE5Px59OukkJIObwKKMK2hmIg9inLwE2seqhnPMiSx/fFoaRl/khZIQWLODIQDg
 oONb+ySUNK0o5Enm5otfMgkdQ0CTtGp7yUgvNlvEE5Jnj7mg3uVKSpTMlvznBTMp+s43
 +dan7kGGdsqtLNEH9HZ81raC78EnZfpC060duN96Z52+5i47aKvlFNjg8+UQQZJREnQ1
 YLzvfp+O4pTDZ728XWn/IcfYsk0L1+75sJVN2VX1BUr5c2TTcJcd57l2QJlwj/SUuUBJ
 CFAA==
X-Gm-Message-State: AOJu0Yw/kLZJ7dq2dZ/lZO3gTws8XnQARxgz1HTfhHBG6cQYcW8Xe3ns
 EM7jmbYNFZpe00zmqx1TbMPCIuBaeEEQU7txVZTLlQsarUrxyT/KPRHL9xZRMKgsAT5oYXUDbFw
 AE0GqF0k=
X-Gm-Gg: AeBDietHiamw1YgEnx0TzlWTA7+aQ0pMWHZKpgSKSc9KYTWRvOVX0/p8wGTSw2dzbEy
 LD7G+ll0vJeUMfMHKj93uumBFQVvmGHBk7qZplMFY8FQ7OFXzRebinszR9UPrdxdqL8pjtS+Eev
 LbUudYoSGvewXB+FZcZ/D4KQbEG0N4glt5VktXTZqyb5DpyphuUs5x/klSeOtiQbY4/w7r8hY1K
 wCyNduzdEuTfm9XNwPonY4FdTsTE9ANQtZVUieiJrhy7dmepMvQupo9uLUKRSsH+Qi7ah2tvXB8
 +bdS8rnmDVjKbRmpON/3MKmuWGENdRveQapqgigfuNYxGjXchvj3H3Q6YvmFemQDExTjV3yn/ZJ
 6qbm3oiaChuL8f2ND98QTEGH8F/qbnBzGgjBFBbC4gEnQ4I3vEj5BJOZL7yrcYz3882krSvkJ1z
 QwUXhObmYKqz8zCQUWUVUe
X-Received: by 2002:a05:6830:3c08:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7dee11e9996mr2167198a34.4.1777741893217; 
 Sat, 02 May 2026 10:11:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:36 -0600
Subject: [PATCH v3 15/19] bsd-user: Add target_to_host_sockaddr_in6
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-15-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=NjTaCPSd2PQWPoUModq1Jl6vHCVrkKMMVYp2dPAAd5k=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QYKCtyJs8RleRJJsRBs7f/3YfP7KSmqZ64
 fjdwF+YrAaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AEjQEAChKfqA+qO96ptEox+ct74MET5UKlP33N4fzppiN5E4vFVi/QCnomhLSx8udxMGyHjV0ke
 KoJiV7EyavSZqwO6PCpkj3MbYdyfOL2QGl7zQ/VPpZ+mD7iabjRG5wOvYNdVQyfay07Lb0vMNaT
 oxxCl0C0FHUASPcPINbBWjSWRdkmzk+KPLl/xf/KMukl+0omWYTzsIUnPLeTc5j6qfgH7mn1h/E
 4y6M1QGkK0QTpL+qIKgmxqyQ6W/pPYb31qXSSPFDtPLjJ63myaS/6f/qfxgVM4uSLXF3EPzGJpB
 FL0eNSpbJyp1JdSIR1/aAA2o+dRiAYMewNgHOkW6d68NvAXANjg/Zn+bL0akEQa2C9UN17qP2Mt
 xH8bQeM2g6huoP4/M9dP//v8B1WdS238LTTUoLzh4DnImBwnKh08ytSGiFVh7SAmaA3jWdNFomm
 gnQKXSeI6bq55DDaAJmIBE0HnwcMPbSEpYz/oQmsB9AnjgqFF/QR0zs0lpM6VKKbzNPMQ+N4HBg
 anj7+Bp20uAZt6xfSo0S+1d4iTyjxWzw2NsA98TnBznt3YjCE3zv1IKYpdujUDTmzRoQjxdlUf2
 VsAxUThNqnxANChIdFEjgH6uEKnOmQFBPpXpm1r1bU22dHhFK4+EBRWuFWXybg6SVMeKbo09vSz
 GGYVvSPEDnpn4HA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add helper function to convert target IPv6 socket address structure
to host format, handling all sockaddr_in6 fields including address,
port, flow info, and scope ID.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 69d1ea1718..d2eb9105fc 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -249,3 +249,14 @@ static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
 {
     return -TARGET_ENXIO;
 }
+
+static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
+        struct target_sockaddr_in6 *tsa_in6)
+{
+    __get_user(hsa_in6->sin6_len, &tsa_in6->sin6_len);
+    __get_user(hsa_in6->sin6_family, &tsa_in6->sin6_family);
+    __get_user(hsa_in6->sin6_port, &tsa_in6->sin6_port);
+    __get_user(hsa_in6->sin6_flowinfo, &tsa_in6->sin6_flowinfo);
+    memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
+    __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
+}

-- 
2.52.0


