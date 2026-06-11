Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E60CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY4M-0004X1-Gt; Thu, 11 Jun 2026 01:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY4G-0004PS-Ow
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:35:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY4F-0003HW-2P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:35:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eedc94d37so3861240f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781156101; x=1781760901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KLzGT8hf3pNfgNBzjpeY4KBubNSC4ge7z/0O6p4NZJE=;
 b=og3CKR+ONuVUHlyH4pD53xV+aDSoTATMZg+lIEa5uh6Xaf/+W3BBVu/uBwN9X2YNtF
 hoHdGcxXfqBdREQlATrABd6abiVafcsb4sPjfSGNSEnIaL2h0bbYCMe6FVXWts9y+ZGe
 YzCpEXQVaGLGCa/BT6ypHukIiCiYJ8zqDShVamzA+9wg5Mm0EjamTXznwhzeTKNYHj1b
 r6pEqZUN3oDcdJ1pU70QlGh42U8TeANVeKsELmiW65FIPQtZocrL4dOgnfiv8MhiYvkp
 HNKtnBFXwwVmPIGyLtO+Cah7fMn035o7FsG49G0kiZrQnesZFaOvTWfBxkCcrT10gfAJ
 aJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156101; x=1781760901;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLzGT8hf3pNfgNBzjpeY4KBubNSC4ge7z/0O6p4NZJE=;
 b=W5LFSNK0YjJckzx7UBuErgBnc7mXL5PUnOxPNlmRa3SBl5OrNo91C+YESZQa777Dhz
 JjDlslG5XEIisDpubwXPL044tmbdX+d2vKbrtst14gxJ+rK1D1rL7Oq/YXZAUy7yyAxH
 +OMrW1Opd16cxjXlubEoN8uAv58sG1T+PlkUIi/h/WfQj+C4s9jRZn1VcK2X63bS3S5P
 PJxUlUGFj5oVDjSoPTXUsTyG1I6oCq79JF2paPexF8xIb0jQ+ArRc95GZvAMtiNcZ6w5
 CQ+naaeUuw/NHincLZa4zB3cz4uGQuQRj17u3yVJ1GDCXGwh5dXgHr7ltd5ZVv2OUKGS
 jDMA==
X-Gm-Message-State: AOJu0Yw3Qe0I0DjgnpBv18tqJstrLMtZHWhKvKL6yiVoe3ccxEVb957K
 v2a84n2pUGA+ZJgUxWyQukNqGFJteBwH3gotV9/ZqYifnZ4rD52FZ+6ERlp9KDK5vqyJ3t5I73W
 KIsxTw4g=
X-Gm-Gg: Acq92OFl5O4Qt6NMr6IIWFnh7bgfsv95+Blxlq6prTRakNdxSgISTYcIRF581roVuB1
 Mm6IsN9cSyWGuq8cRO2dOwKoeu8c0kPb7MxZNHZ1cFywkImZCnDB4xftYNqJfRJnTX1W+tgDGRl
 /KVZWsdWykq3F0e+Mzgc9jOV7O22lhDmdeJH8izLbg7lHExfp6IFBZZzEDMY5w6/TaTCbs9OSdK
 XruiRTj1Mflc7/O+eaJYmIEYiye7AaHBmh9fH+smr91TnRF2gMudUjJYG6zdyMn3U6kw0X9/6Ne
 WR+CPKLEt2Mw8fSdEhJncuhIp80zCnSqobizlODgNHTkeAt1hB866VXZMDphp8Hm+dlclbHkliy
 XUN0cSJo1cRlA+s6qV5UPiKcTZzD4eVxDCzlQzP8XBZ9X3owmf6uZHHG5sgXURozqqiGCXQrv5z
 f8UxyM+BiAB6FxvIGmJgYTOr4YTwTNlrYxzjyiwzhAGmPZFkJ+FknR08R18SZJ7fKw/Y1ALKCv1
 flWcFDWCTre5/i8LiVByGJAaSyt+8rJBfhg+uZZ92S/5VXjJJy9zbmZl2xzDQ==
X-Received: by 2002:a5d:5d11:0:b0:45e:ed7f:1dd with SMTP id
 ffacd0b85a97d-460677b1ad6mr1577990f8f.25.1781156101138; 
 Wed, 10 Jun 2026 22:35:01 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm65211950f8f.7.2026.06.10.22.35.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:35:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:34:17 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 11/25] plugins: add userdata to qemu_plugin_vcpu_for_each
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-12-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-12-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcuc.1wsttyk880x47@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 4 +++-
> plugins/core.c                | 9 ++++++---
> 2 files changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 8c146ea49c2..320644a2f0a 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -957,6 +957,7 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
>  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: user data for callback
>  *
>  * The @cb function is called once for each existing vCPU.
>  *
>@@ -964,7 +965,8 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>-                               qemu_plugin_vcpu_simple_cb_t cb);
>+                               qemu_plugin_vcpu_udata_cb_t cb,
>+                               void *userdata);
> 
> /**
>  * qemu_plugin_register_flush_cb() - register code cache flush callback
>diff --git a/plugins/core.c b/plugins/core.c
>index aa9240fe21a..a5aac1062aa 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -296,18 +296,20 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
> 
> struct plugin_for_each_args {
>     struct qemu_plugin_ctx *ctx;
>-    qemu_plugin_vcpu_simple_cb_t cb;
>+    qemu_plugin_vcpu_udata_cb_t cb;
>+    void *userdata;
> };
> 
> static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
> {
>     struct plugin_for_each_args *args = udata;
>     int cpu_index = *(int *)k;
>-    args->cb(cpu_index);
>+    args->cb(cpu_index, args->userdata);
> }
> 
> void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>-                               qemu_plugin_vcpu_simple_cb_t cb)
>+                               qemu_plugin_vcpu_udata_cb_t cb,
>+                               void *userdata)
> {
>     struct plugin_for_each_args args;
> 
>@@ -317,6 +319,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>     qemu_rec_mutex_lock(&plugin.lock);
>     args.ctx = plugin_id_to_ctx_locked(id);
>     args.cb = cb;
>+    args.userdata = userdata;
>     g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
>     qemu_rec_mutex_unlock(&plugin.lock);
> }
>-- 
>2.43.0
>
>

