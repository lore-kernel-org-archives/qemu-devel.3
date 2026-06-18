Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDBFCD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvA-0006g4-LA; Thu, 18 Jun 2026 08:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBv6-0006ZE-U2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBv5-0001BW-1k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ICV2BB1814189
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zkfR8veePb/Px6zo7DvuTaT6t9EWBe81grmTNxfGyZk=; b=PitS9RJDT/KkAuei
 4zjjGAiUj0G/msEK1zhJxbYRGyvqXjnoKdo56MUDNBVmvlhQVepy1risOlzwmRsU
 maXyaj1oVAkeCSXArlxj4HohJUHclFMfORSailkr2YBFLLO1NWF9CEQtf5IrnY0r
 kYgVzrPjh1AtP86940UA+OdbGdu26TKXcUv3TepcBYyFPUeTDlF2pCeb5RDagCEA
 4wVAbBc6MBTWkk5M3K+deXce8t8bR93MZ7SvZl4b7xEDkg+UrLqoBVXxIFrgqywR
 vBZ76Gao86c+9DwTXeHOZU9/qUcKhsAs3DntL9LhkexqAhDU4S1jC8zb8CProcgm
 gJaYyw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jvg10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:29 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48656ba24fdso1469516b6e.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785949; x=1782390749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zkfR8veePb/Px6zo7DvuTaT6t9EWBe81grmTNxfGyZk=;
 b=E7okyKK9avT4Ido+65izK9i3IxMKtWX/RS8TJ6T05I+WVINfxgxtAsgaJFiD0ETjBk
 bdIZvK01jtJdsQXnR0k0nBRiMU8kVSFA58kur3Ma6f+ekcgCwMw5p6owjVDQ2sO4hPv7
 jqINUaCaZGH66lP/kxwRrH3NI2NjxIVrahmMUIc8QixOnB3PyQ7mRhQE2yfBJV663QA/
 h3ewPheWB0bofv5tRTQ8Q+KF1Doc7WLvU1wV09FSWnQm/Uf1ULRkcQ7CqVHfjK6aqr75
 rLorfLSHPPVKcBK5UcHWN6gFy2FsTOHL7pJ4BooL3kkiglAL4ihqd9hH/P+7EXdwVxdH
 W+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785949; x=1782390749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zkfR8veePb/Px6zo7DvuTaT6t9EWBe81grmTNxfGyZk=;
 b=MS3ltc6KzPjCSJ0SN3dyGgcFlnLLvwMGSDQo+GN1NCMa5BCqY1J2csaA/R9+DrnJL7
 IACEFvmoLrsa092sPv8MhfIpQ8ft5tZ7WhuIPZlX4bV498kToNEkU+QszrZcdxZBF8l5
 T1N2CxlMa+Q9n046E2mXlZGeSYKH4PbKFJekEWf272a2IN+QMWBdmhWJb852wahp+LNK
 9vSpKmHZzyWjGgetX7HOZhIfZcScGcywzh95lR8fscsDN+TyOFcXzXSFRfXPUSrQMdo1
 gCEKZ5LfACH373q5mnBUh88rbRCw9Gw+NxP444MNRdTi/yTljX6dKN5ZVvAL7vNUmvj9
 EpTA==
X-Gm-Message-State: AOJu0Yym+KVc7zOEEh8/NT1h3POhLkHOvh/A5Aki/K+4CIWbKh7p+yEn
 06jsMRZaaA4ntqw3Glzx9WttXwmvgIFM8N+KamMFkxyB7N6efGz5eqhG4ngaXtVR/7nPi3bcGNZ
 bFJO182rQsvzEu51ZG2uftyRxZ+6rq3/wXapMMgJQklcOYKXPOcHIhqLLsIElPPYAnA==
X-Gm-Gg: Acq92OEqEpb8Oj0/MtOXLfm8ZwWOawBCAsfBJm62gSS851Z/h3R+QniAhkka4yY9/7K
 JtbZ+tIYbovlaiRO8qZk6Bb8VdkdLFgjgD2f4ZcLlGxPIB5eudCKWQ8FNE+0hA9qVNpMAapGhW7
 Jg9b68VjF5SZHkZq6KK61WZi85NLhMcm6bRoXuaO9wiC0dJ1ENa9mUQ+u7oKowV/T36hvh8YcPw
 hukStmN0Kb2t1ynch9cYTRH15OOEolo5NAb+Cardt0rUoGshCIdeQXeXAo7LAHHONbW+j+rE1Zo
 QkrKjvmLwaXaImwqQ9yXHIv7yo1Lk0C9CvNn6WNiRhvvJnMnR7IZrrG7w554LeIkzwqaXUHRvoc
 p2Fh9Il1lR0iXQSIawcV89EzoqsRpQNRjMySE68ZVDxIb9K2qUXb9GzUZUPHr8JtjVz6z
X-Received: by 2002:a05:6808:1785:b0:479:da60:7dd4 with SMTP id
 5614622812f47-48942a745c2mr6545153b6e.30.1781785949248; 
 Thu, 18 Jun 2026 05:32:29 -0700 (PDT)
X-Received: by 2002:a05:6808:1785:b0:479:da60:7dd4 with SMTP id
 5614622812f47-48942a745c2mr6545081b6e.30.1781785948238; 
 Thu, 18 Jun 2026 05:32:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462236047c8sm18690657f8f.10.2026.06.18.05.32.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/48] ui/cocoa: Use qemu_input_map_osx_to_linux
Date: Thu, 18 Jun 2026 14:28:10 +0200
Message-ID: <20260618122825.90331-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXxEupgJ3tBZth
 QUwj/+TfVXYd/RTGpdp/6EVoZfmsofchBc4EknPlYPG+VKH7Kouk0j8L9+FntOH6HugkzNNWVGE
 1xI4KuWX/gPj2FZjwcYvSA/od8Lg8Nzrx/7pDnaOt32CIXH3sZb/58Dv/EenBr0O2gRkvxZj0W8
 snt9aPNxnisMPmOlved0xF/vcR0i7mS3QtsDhWplJOEdl73ZydV9kd0IOhUuetDrr6mnYYpGOaG
 ClNuNL2JDkF2al0rPuymK2UFCA6vScoH5tEBnV5fvfzPGXMzt61ksNynNT+Xqvqm3IStUZFEUQS
 CS5UkTuETw8vQbVicuFOVu1ixgDoQczhK0WzRi8SHnAl0dnNyf6nee5DcYFInHMz0KmYp6/q9PY
 2Px59S2d6951KtvVUAFOabqf/NLg0HVHyo6Ka1gXK7bYIvxgF7YfZPEIAJymZJaeQQYVXvkHfjW
 ACAhegB9E9o7Q0B6SNw==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33e55e cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=t-IPkPogAAAA:8 a=yMhMjlubAAAA:8 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8
 a=8pla2JGJaMdYiOrBke0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: 21_ACvYbDeBJyBYpylbjq-4MCc4ZI9bx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXw2rF95paYx4x
 D39n5KjxrYBQlxk5IoAF57rUx8Hu7qGz4T7xJ6k0uoiOp4sNvuLY8vDV370PQxtJfyS96w0kzLZ
 5/+rfD2blox1IWqhYN1qIFBUhbmvLlQ=
X-Proofpoint-GUID: 21_ACvYbDeBJyBYpylbjq-4MCc4ZI9bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

ui/cocoa used to have a conversion table from macOS keycode to Linux
key code. It is an unnecessary redundancy as ui/input-keymap.c already
has such a table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
JIS keyboards").

According to the following documentations, the definitions in
ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime

Use qemu_input_map_osx_to_linux to eliminate the redundancy and
incorrect mappings.

Fixes: 708b72557ff5 ("ui/cocoa: Support unique keys of JIS keyboards")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-ID: <20260604-osx-v3-1-453b4ee0e072@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 ui/cocoa.m | 131 ++---------------------------------------------------
 1 file changed, 3 insertions(+), 128 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c5e639ab98d..e157ad01d85 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -141,138 +141,13 @@ static bool bool_with_bql(BoolCodeBlock block)
     return val;
 }
 
-// Mac to Linux conversion
-static const unsigned int mac_to_linux_map[] = {
-    [kVK_ANSI_A] = KEY_A,
-    [kVK_ANSI_B] = KEY_B,
-    [kVK_ANSI_C] = KEY_C,
-    [kVK_ANSI_D] = KEY_D,
-    [kVK_ANSI_E] = KEY_E,
-    [kVK_ANSI_F] = KEY_F,
-    [kVK_ANSI_G] = KEY_G,
-    [kVK_ANSI_H] = KEY_H,
-    [kVK_ANSI_I] = KEY_I,
-    [kVK_ANSI_J] = KEY_J,
-    [kVK_ANSI_K] = KEY_K,
-    [kVK_ANSI_L] = KEY_L,
-    [kVK_ANSI_M] = KEY_M,
-    [kVK_ANSI_N] = KEY_N,
-    [kVK_ANSI_O] = KEY_O,
-    [kVK_ANSI_P] = KEY_P,
-    [kVK_ANSI_Q] = KEY_Q,
-    [kVK_ANSI_R] = KEY_R,
-    [kVK_ANSI_S] = KEY_S,
-    [kVK_ANSI_T] = KEY_T,
-    [kVK_ANSI_U] = KEY_U,
-    [kVK_ANSI_V] = KEY_V,
-    [kVK_ANSI_W] = KEY_W,
-    [kVK_ANSI_X] = KEY_X,
-    [kVK_ANSI_Y] = KEY_Y,
-    [kVK_ANSI_Z] = KEY_Z,
-
-    [kVK_ANSI_0] = KEY_0,
-    [kVK_ANSI_1] = KEY_1,
-    [kVK_ANSI_2] = KEY_2,
-    [kVK_ANSI_3] = KEY_3,
-    [kVK_ANSI_4] = KEY_4,
-    [kVK_ANSI_5] = KEY_5,
-    [kVK_ANSI_6] = KEY_6,
-    [kVK_ANSI_7] = KEY_7,
-    [kVK_ANSI_8] = KEY_8,
-    [kVK_ANSI_9] = KEY_9,
-
-    [kVK_ANSI_Grave] = KEY_GRAVE,
-    [kVK_ANSI_Minus] = KEY_MINUS,
-    [kVK_ANSI_Equal] = KEY_EQUAL,
-    [kVK_Delete] = KEY_BACKSPACE,
-    [kVK_CapsLock] = KEY_CAPSLOCK,
-    [kVK_Tab] = KEY_TAB,
-    [kVK_Return] = KEY_ENTER,
-    [kVK_ANSI_LeftBracket] = KEY_LEFTBRACE,
-    [kVK_ANSI_RightBracket] = KEY_RIGHTBRACE,
-    [kVK_ANSI_Backslash] = KEY_BACKSLASH,
-    [kVK_ANSI_Semicolon] = KEY_SEMICOLON,
-    [kVK_ANSI_Quote] = KEY_APOSTROPHE,
-    [kVK_ANSI_Comma] = KEY_COMMA,
-    [kVK_ANSI_Period] = KEY_DOT,
-    [kVK_ANSI_Slash] = KEY_SLASH,
-    [kVK_Space] = KEY_SPACE,
-
-    [kVK_ANSI_Keypad0] = KEY_KP0,
-    [kVK_ANSI_Keypad1] = KEY_KP1,
-    [kVK_ANSI_Keypad2] = KEY_KP2,
-    [kVK_ANSI_Keypad3] = KEY_KP3,
-    [kVK_ANSI_Keypad4] = KEY_KP4,
-    [kVK_ANSI_Keypad5] = KEY_KP5,
-    [kVK_ANSI_Keypad6] = KEY_KP6,
-    [kVK_ANSI_Keypad7] = KEY_KP7,
-    [kVK_ANSI_Keypad8] = KEY_KP8,
-    [kVK_ANSI_Keypad9] = KEY_KP9,
-    [kVK_ANSI_KeypadDecimal] = KEY_KPDOT,
-    [kVK_ANSI_KeypadEnter] = KEY_KPENTER,
-    [kVK_ANSI_KeypadPlus] = KEY_KPPLUS,
-    [kVK_ANSI_KeypadMinus] = KEY_KPMINUS,
-    [kVK_ANSI_KeypadMultiply] = KEY_KPASTERISK,
-    [kVK_ANSI_KeypadDivide] = KEY_KPSLASH,
-    [kVK_ANSI_KeypadEquals] = KEY_KPEQUAL,
-    [kVK_ANSI_KeypadClear] = KEY_NUMLOCK,
-
-    [kVK_UpArrow] = KEY_UP,
-    [kVK_DownArrow] = KEY_DOWN,
-    [kVK_LeftArrow] = KEY_LEFT,
-    [kVK_RightArrow] = KEY_RIGHT,
-
-    [kVK_Help] = KEY_INSERT,
-    [kVK_Home] = KEY_HOME,
-    [kVK_PageUp] = KEY_PAGEUP,
-    [kVK_PageDown] = KEY_PAGEDOWN,
-    [kVK_End] = KEY_END,
-    [kVK_ForwardDelete] = KEY_DELETE,
-
-    [kVK_Escape] = KEY_ESC,
-
-    /* The Power key can't be used directly because the operating system uses
-     * it. This key can be emulated by using it in place of another key such as
-     * F1. Don't forget to disable the real key binding.
-     */
-    /* [kVK_F1] = KEY_POWER, */
-
-    [kVK_F1] = KEY_F1,
-    [kVK_F2] = KEY_F2,
-    [kVK_F3] = KEY_F3,
-    [kVK_F4] = KEY_F4,
-    [kVK_F5] = KEY_F5,
-    [kVK_F6] = KEY_F6,
-    [kVK_F7] = KEY_F7,
-    [kVK_F8] = KEY_F8,
-    [kVK_F9] = KEY_F9,
-    [kVK_F10] = KEY_F10,
-    [kVK_F11] = KEY_F11,
-    [kVK_F12] = KEY_F12,
-    [kVK_F13] = KEY_SYSRQ,
-    [kVK_F14] = KEY_SCROLLLOCK,
-    [kVK_F15] = KEY_PAUSE,
-
-    // JIS keyboards only
-    [kVK_JIS_Yen] = KEY_YEN,
-    [kVK_JIS_Underscore] = KEY_RO,
-    [kVK_JIS_KeypadComma] = KEY_KPCOMMA,
-    [kVK_JIS_Eisu] = KEY_MUHENKAN,
-    [kVK_JIS_Kana] = KEY_HENKAN,
-
-    /*
-     * The eject and volume keys can't be used here because they are handled at
-     * a lower level than what an Application can see.
-     */
-};
-
-static unsigned int cocoa_keycode_to_linux(int keycode)
+static int cocoa_keycode_to_linux(int keycode)
 {
-    if (ARRAY_SIZE(mac_to_linux_map) <= keycode) {
+    if (qemu_input_map_osx_to_linux_len <= keycode) {
         error_report("(cocoa) warning unknown keycode 0x%x", keycode);
         return 0;
     }
-    return mac_to_linux_map[keycode];
+    return qemu_input_map_osx_to_linux[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */
-- 
2.53.0


