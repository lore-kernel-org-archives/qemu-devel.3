Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CA4CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDU-0004rB-F6; Tue, 14 Oct 2025 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDS-0004pd-Au
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDP-0000xq-Ot
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9x2xBqXLvD3TD22ZGiq+KsjrIorcQc7dSOkJFfUH7FU=;
 b=V6YgnszRMFTJ4Pw7jTzQeR9LRaJ2tKDlEDkytUKnsHr9ecgQ6wz4xccP5OR7bjAK6Bn/41
 PWbKz63YKdypaNwwJAEifJ7V9HRh8deYndB7N8WqUyOsxXw2ZgRFMy304bCqpRydYlKmyW
 zR1Q/nfi0RRzViKHT6gXWKZIIRc8NIU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-_X79uieCOlKeeGGDtZD6NA-1; Tue, 14 Oct 2025 09:37:17 -0400
X-MC-Unique: _X79uieCOlKeeGGDtZD6NA-1
X-Mimecast-MFC-AGG-ID: _X79uieCOlKeeGGDtZD6NA_1760449036
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so5770357f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449035; x=1761053835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x2xBqXLvD3TD22ZGiq+KsjrIorcQc7dSOkJFfUH7FU=;
 b=Ncb3yCS4oUBvwxRehcfXiBfoZHC2wa3ToOWpSXI4PvYsP/AnR4wgqFuZmFJOVm36j2
 Sfmhtzf9DP5+wznvpjKqBnsnYIlksiniLDsD+HjsVdL4CRFSERKJmGGCrGetyflfvUpw
 8rkG2Rp04fdbiy6L1LtZ/hlAjWe1wx/zhcWllzo+meZvkUZ56pf+hPjzNI37mHDgjVHb
 8tIzKPWxvClDROh4tQlt427SEslkbIiETH5zHxdz511Ovnt8xZQCuvML0IRXVTnJ9/We
 4NglE6mxYw2hHkbwgp746+JqX9JcYAcR5A6YY7nxl35TE16hx2+1dsOd2eY0Uc9iL2Aa
 NmSg==
X-Gm-Message-State: AOJu0YwWqEUPt3HLdxcM5wLfIbQ6lNMxhMuypNEMyVnWLO8z9od4GZ77
 J8ySqAUQGb7xq/ll4xo/1qk4UrEVaAtWxQLLw4yIvPs2hfddCnYJFZJZdwPBVgL19xxMDc91AOc
 b/0wsgA9MsCBNHKDnOMY8eTCXe5pcVbxYzVWxlc5AC9WeZnsCuERgLAuRO5xWZwJS5x3j9G7mYV
 7Be+MfgsqPxC5YjyVpiY/60QsyU2RSmrBm9qt5pI26
X-Gm-Gg: ASbGncvy/W4VP+nZMDbsaXxhnFL42+hwRPC5e/EzTfVEjNdHAFXQBhG557oqxPnF7oc
 TycIKSMxFVI/2qakoJC1mdcZWDzDwXxR9HR2imTXqKcWQmUVwjJqFBqnvci2PcQZqyklnI8aI0o
 pYhf/ovOQBngPoZu0Fn8YeS8U+iuNr2yXfYHi3iziEfn4FUjpZ/7OuNG6IbXw9DXmsMbtokFIAA
 B1GZIhc4ryD9TuUJBQeEtRehCMCmp9KFmjfwW+tLvQ4MITnG9BNvL34XOaFvLLSPdx4FAHOZJfY
 wsPkcblQSw3Ne5Qk1xZKasJ2rki86XMSUMSwYiY0cd3XE20xfvfyLrzwacgFZjfn1zgh4it+sXH
 fBhD8YO2X3NBbi+7tK/kteK2Adc7mEp1uA2Cs1uWDU70=
X-Received: by 2002:a5d:5c8a:0:b0:3e0:2a95:dc90 with SMTP id
 ffacd0b85a97d-4266e7e1438mr16446142f8f.35.1760449035054; 
 Tue, 14 Oct 2025 06:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+DOgeWJPw+2zO4YmZJy5Tyw9ra26azI7iTBQiCuOjeJpkADdEmJuSgZijPwN/VzK1XguE5A==
X-Received: by 2002:a5d:5c8a:0:b0:3e0:2a95:dc90 with SMTP id
 ffacd0b85a97d-4266e7e1438mr16446123f8f.35.1760449034584; 
 Tue, 14 Oct 2025 06:37:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e13b6sm23800764f8f.44.2025.10.14.06.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/28] rust: pl011: fix warning with new clippy
Date: Tue, 14 Oct 2025 15:36:46 +0200
Message-ID: <20251014133713.1103695-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Newer versions of clippy are able to see that all the variants in
the PL011 word length enum end with "Bits", and complain about it.
Allow it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/registers.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 0c3a4d7d214..fa572811b29 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -255,6 +255,7 @@ pub enum Mode {
 
 #[bitsize(2)]
 #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+#[allow(clippy::enum_variant_names)]
 /// `WLEN` Word length, field of [Line Control register](LineControl).
 ///
 /// These bits indicate the number of data bits transmitted or received in a
-- 
2.51.0


