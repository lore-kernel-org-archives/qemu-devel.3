Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E01606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n2DDni4T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSnY0-0000uF-Oo; Sun, 15 Nov 2026 22:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xSnXy-0000qB-EI
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 22:38:22 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xSnXw-0008Dm-Hs
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 22:38:22 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-71adbbf09d8so1024634eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 19:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794800299; x=1795405099; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M760Ygh1lMS5cssuQZVdGw+HrfQj6IlfhNSMlYCYFEI=;
 b=n2DDni4TW/HlPgahmXj5FkZ7X4IuFyYGLvfQSmH/eanF1aPXNf6Uc5xvKcCI2EoPE8
 U16dPKzhF4fN1AObWwu0ibkCgDoSzb5sER+8gP9IkOk62ATOUo7M+BWpwEV1rc1GlVOe
 k/IWbkFxvFy5f4FqxOV/6rbzGofPd8oYNR85Lik5iTUpFSPXh+WRp4/oXJVNkwqB98Uf
 CFy529GZeVGBrtf5NoQKj+kORgaIKkzC+Ut3+SwavFpPiNjEe5wOypa5bRmhYgiovmQN
 T2rloRP8wOH7ZlJLUE08+pTaOF+CfIzpupdNorCXaFE9aaYc63kgD3TjeJNvUDUo/1t1
 HG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794800299; x=1795405099;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M760Ygh1lMS5cssuQZVdGw+HrfQj6IlfhNSMlYCYFEI=;
 b=u44WhImmbkKPTcYDd86mMAU4vWeO038Yn53FKzhvKQ2HxHz8wubMQTIW7s/Ouhubfl
 QW5gSBmYDEqIFfrDqEcNmAPZMmOd5bDyKcb8dQliyqW3ZIVcbIzJJwO+PkL41ESN/zgf
 phMWxECBGWESl4+Xe5ak7Sdlrquu0VStydhjbQPaT0KwpxM1G4qdW/dn/1S5FakooDKD
 wUGlkbdNS15m1OWPah0gS5XQaCU/GsgSGip/MX8IL0MvjKMDVSZdHkKIFGgaFp/XUaQL
 BmcjYJoCMlOk/c4MPBIJVoHZXCJMY8lWesvaF72BOBUCGX+1IAcCSyl4rPKzw/fNs3YX
 A8Ew==
X-Gm-Message-State: APuU4Z+fFF9BcZgTt35bQ+tK1rlrSZDLH6+tsSPU+t9jCT88DSoYjdum
 3cSMKIlrKy38w5lYse/uC4c0rGnJIU5xaJJUasIf57Wcg7YPmFkjxauK
X-Gm-Gg: AYBFou3TeB+eqY8Y+ROFu8SDlwtudS8GZODIAlRJG4C/gxTu8gpoFnNE0eQ+Sf/qE4+
 LtiFl5oY/L+NNMNPZKk1oYQLHnhrreSEZC6OPY+mD+CX0G+w5MnzdmJQBkIaV4ktbcqJdeuUeU2
 t9ykxbU3ffIX9SnpB37MQaqTQetvQHuqVNGaIvcUWs5IwwrnqPLRl3KfzUZ8GO8n8YGO3ONxbci
 R7S/RXYgzOy6EM47GJuKbf/Ul32hT9VwaxRJeHzfTT33xd3dp8XdNrNR4id/o1TB+OYRoVET/6c
 ZwfvxvYaRNTb4FtUwNBPOTzuWL4gtzxkLRUtant6npIw8vxJpso1CkmHcGyj5JRT2HknosGJod+
 kiD9RfxDpjcaEVRC+UXFykFlNI0phAW4YLV24WsSWUp01fwJNQdSVo/DQeLXCRXppNP/WyPbKHq
 SqVA1c/86iX5rP+9KLcQffF7ysYhMSpjVEz2MnHnqlP4Zml9GSeAw+L1sU5sfBDv0gUDaUAXxQU
 6rODLN5U06jpvRa8DLgK+tQva1u6i8/zmhDQrCkoQg4VoAOWAr20sOo8TZjib9gRgzRDvAk06id
 O0DY9/svRVvXphGuNbdvgSzPOUS30SCpUBNFYOv3R7k+lEHq
X-Received: by 2002:a05:6820:81e:b0:71a:d594:e831 with SMTP id
 006d021491bc7-71ad594f240mr2609845eaf.36.1794800299276; 
 Sun, 15 Nov 2026 19:38:19 -0800 (PST)
Received: from [127.0.1.1] ([2605:ad80:33:509c:d439:680c:b591:d1b2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab4335912sm7523451eaf.13.2026.11.15.19.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 19:38:18 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Sun, 15 Nov 2026 21:38:02 -0600
Subject: [PATCH] target/i386: make error message for -cpu host more informative
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJl6+moC/x3MSQqAMAxA0auUrA2YOuJVxIVDtNm0kqoI4t0tL
 t/i/wciq3CEzjygfEmU4BMoMzC70W+MsiSDzW1NRBWWbVHjvJ/oQjyQVYMicVtN1HC+0gKp3JV
 Xuf9rP7zvB8y1eVhlAAAA
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794800297; l=1680;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=Dr+9mb6M3YR6t5QP2S0QwtBj0rEB1PhVrsG2rhdCZcQ=;
 b=9ITfSpK8+LD9e+QxEjYQp1nXQUBTIuBQmaDxfBUwxzgaOIDUkMIjjMfyUJvrORTewXXZSw5Xz
 Gn0C00nHf3ZBjPZ//TG122h5lCwl59nw/Izo9W5v6THYJy0djwN6x6v
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=xmphyr@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Included the mention of WHPX when the option -cpu host doesn't have
an accelerator option.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
---
This is a resolution for issue #4836: https://gitlab.com/qemu-project/qemu/-/work_items/4836.
"-cpu host" by itself is not permitted; an accelerator must be specified as well. For Linux,
it is KVM. macOS is HVF and Windows is WHPX. 

Previously, QEMU would only tell the user to use either KVM or HVF, essentially excluding 
Windows users. This patch adds WHPX to the error message. A similar patch was made seven
months ago in target/arm/cpu.c:1861.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
Changes:
- cpu.c:10229: added WHPX to the error message when "-cpu host" doesn't include an accelerator
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..7dd5535f80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         g_autofree char *name = x86_cpu_class_get_model_name(xcc);
-        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
+        error_setg(&local_err, "The '%s' CPU type can only be used with KVM,
+            HVF or WHPX", name);
         goto out;
     }
 

---
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
change-id: 20261115-4836-cpu-host-error-1e85b17e0f1d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>


